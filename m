Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8AFC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6422406ED;
	Mon, 27 Jul 2026 11:04:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2yGpD0J-rkY; Mon, 27 Jul 2026 11:03:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0466840651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785150239;
	bh=1OF6HhczN1tc4fLoDtN/WEECDDOOfOyeE1NDWjznATs=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=vybVTDompI6ziAsbqGq23u43Qj0+2ZEcPIQqhW96HDOoW6jVi51sG5MrC51TpI1wp
	 NPdT6CADgHqYdnOpikiLatIWbyOFvJmArVTIU6/dH7m4T8e58udkrrkm0a7Ae+mkST
	 SLTV109qqAqDFgjRL1ExNwr74gtH/9GxyZVMekY99wki2Seyq6YS5K/XgwCYRYHkrJ
	 6bcRRZq4KCtg0FI4/zGHJvTc7xWdhnBUjF2tQp4W3PiFWtln1Cn+ZPYhj1H92NFIrE
	 RfSXBa7nw8iv4Aiu7exdcTFqseBwJk64LsCYVGtOvdvORQbp4HclyWAaeFVYj6qpaC
	 r3cuJuNVy1kaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0466840651;
	Mon, 27 Jul 2026 11:03:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5197B357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42D42606A7
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:03:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ng3fIImdbyHz for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:03:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CC391606A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC391606A5
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC391606A5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:03:54 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D45CF400E6
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:03:51 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49554715277so25072975e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785150231; x=1785755031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1OF6HhczN1tc4fLoDtN/WEECDDOOfOyeE1NDWjznATs=;
 b=E7rIrz0n6Zoi+BMWs8xTlwgDID1z+K7p8aBbA5S26IAhHi2ImAcpTOTRpw6yOSPRoS
 Lqbb+c41OqLEdUHzdf8zviK9DgC6iOLOtNSlGfZJzgwQR6W23bpN4bnUjkMhWfIsER3O
 E4gs4E7XH5c9yboCEJnelbx134W1Hwc9EL+nqiTSk8W+azJNetDzcEOzAcKaO2sLZQgC
 7MXwvqnP4ECJCXurXVHsW44ddZhsDjUAjIyLk2o0vIxwCooPHgF6cErNNZ+npHaLD8Da
 m3n94FtvUj2VKlwKzuyKtHCxw5YSO0VSYGx4M1wOO4xeOoMmvR2+vjNzKzbVxtaSXEXP
 0HvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRNgwDK2GKN0YuJf+FpHAHFyqZ2QsDhJy94F2ou709DTtuN2HdpCReTuhZgRz3FUwF9LABK1Y=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwiEtOqMagVhy+5xAGqsIVf61TDV2KWYg4UcwoGCoYkPnKgWYog
 bmUcBRv8eUltzqquQ2ERI7WNY8F68fadNhwAK8qtv61PD3pAAVFc/N/DHNv5fVUDsEB6uSYbRtN
 2g+6+zIafrQzW93Hu/ayli1a7EL/mWV8t7Ls1Y7OzRgbyHcdhQE9kbhsRp2xOuCn6R5PfGtliSW
 BnvHYBG9fJtA==
X-Gm-Gg: AR+sD10lqYFD5ZQg6LSb/Fgwo9xAP3HKOQSQfMKIhoW8EyS6JwloZs8l0zYfB2WwJ2Z
 lE0Wgik0b7VtzTc7MC9JVlRVB+1JkP+RTvSNBv8qI1iegMFTozfhK31+eQw2mmIXtJe6vVXeEFK
 koIATmAl8e24EFWaxqw1veKrHuHG4kv8BfG53mGv0tfzGf8B0by0s4ywDnqJcbhi06iqYacGL/j
 o7BgWRs5ObThITwsIxI3kaLx3PhJ9ybE0kTPCbhnd5rhC8YeGzZGigKQQlDxsK4NZJvmNarYo3M
 EeyY61EhXIqYqo78sCvjX7sTvBP30khBNDlRJVgrMVxVbxgKnjWXxRgIXQ6ay8ggDard6MIQV81
 vpiOiHM4RfX1H8Ojr3lBJCVwsG9GPcajtDOrUgrmpSRV9BiJukiLBpEXi
X-Received: by 2002:a05:600c:8b35:b0:495:6936:120e with SMTP id
 5b1f17b1804b1-496b57108b3mr98472265e9.39.1785150231499; 
 Mon, 27 Jul 2026 04:03:51 -0700 (PDT)
X-Received: by 2002:a05:600c:8b35:b0:495:6936:120e with SMTP id
 5b1f17b1804b1-496b57108b3mr98471745e9.39.1785150230991; 
 Mon, 27 Jul 2026 04:03:50 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:96c0:6fce:32a7:7281])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c631fdsm46630631f8f.28.2026.07.27.04.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 04:03:50 -0700 (PDT)
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_loader: check efi_deserialize_load_option() in
 get_dp_device()
Date: Mon, 27 Jul 2026 13:03:36 +0200
Message-ID: <20260727110336.71692-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785150231;
 bh=1OF6HhczN1tc4fLoDtN/WEECDDOOfOyeE1NDWjznATs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CeGj6DZDv575RQtB9o7womily+2vsBo4VRsiNrJJuAukWu5W/ClrBfzfgflkay9AY
 zM0CTREwH9Edrp4HgDWH91jvtI+v+j6HPUt1ZOYHE04FWVdBc/5RZBi4YXIhyBLyz/
 NuG9/iN9mdDyLOAkYKY/mjJds6zviY6SgTlxjoRs++Np9erIrY7+n6f8auc8nrcY75
 P4LgFXtvFYahP3RLvsPCHNyew5/lFmhCzF97eVJFYLfEmCXAi/ohWAy8fFHLU4vfx/
 2zAYkdfvlVVMPe2z9+kCr4xHBmqY93cmGHyAWyJ+z0kvRY6XlbOM7lYxW9XBLTZtTc
 SjEpt2lWHY3KGhM6olnbuEqcUhbwNYGdcF/RPsMUI248zB6tGS/mHaOqp1hydHl6U5
 bR4C9keylxmbURldtcYDWk0KJ2K3eloLQO3jBeROwIRWJ9eqBpK79tb9qflACWtxKh
 OvhoHoAst25afNud1e+WnZ87xAzzMmbJQ9+M7NcL9AdnLqrgHdKs4P0YQd6oDEaTA8
 cj+UQTPewCE8wqh4bjXHrjcvMrj5k5/XbMMa3apwF8FIxx/0kmKOWUGjMkFo6q/AmP
 XxO4QGSZlj5N/xWSJ1Y11mNhizoLT4HZPZ1nM/ILxVNOsabMnOXzwnxWH4rlKBn7qv
 RBB9nS45MQVPNnP/xhotplGQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=CeGj6DZD
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From Hem Parekh <hemparekh1596@gmail.com>

get_dp_device() reads a Boot#### variable and passes its contents to
efi_deserialize_load_option() but ignores the return value. On failure
efi_deserialize_load_option() may return without having initialised the
caller's struct efi_load_option, and even on a malformed device path it
sets lo.file_path before validating it with efi_dp_check_length().

As a result get_dp_device() can proceed to walk lo.file_path with
efi_dp_split_file_path() (via efi_dp_dup()/efi_dp_size()) on a device
path that was never validated, or on an uninitialised pointer when the
variable is too short to be parsed. A device-path node with a length of
zero makes the walk loop forever, and a length below the 4-byte node
header leads to an out-of-bounds read. The Boot#### variable is
attacker-controlled in threat models where writing EFI variables does
not imply the ability to execute firmware code, so this is reachable
during capsule-on-disk processing at boot.

Check the return value and bail out, as every other caller of
efi_deserialize_load_option() already does.

Suggested-by: Hem Parekh <hemparekh1596@gmail.com>
Cc: Hem Parekh <hemparekh1596@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Use common exit out:
        Remove invalid Signed-off-by: Hem Parekh <your.real@email.com>
        Changed error message: remove word 'for'
---
 lib/efi_loader/efi_capsule.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 52887f7c274..a77810fa15c 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -860,7 +860,11 @@ static efi_status_t get_dp_device(u16 *boot_var,
 	if (!buf)
 		return EFI_NOT_FOUND;
 
-	efi_deserialize_load_option(&lo, buf, &size);
+	ret = efi_deserialize_load_option(&lo, buf, &size);
+	if (ret != EFI_SUCCESS) {
+		log_err("Invalid load option %ls\n", boot_var);
+		goto out;
+	}
 
 	if (lo.attributes & LOAD_OPTION_ACTIVE) {
 		efi_dp_split_file_path(lo.file_path, device_dp, &file_dp);
@@ -871,6 +875,7 @@ static efi_status_t get_dp_device(u16 *boot_var,
 		ret = EFI_NOT_FOUND;
 	}
 
+out:
 	free(buf);
 
 	return ret;
-- 
2.53.0

