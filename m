Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C7606A32C
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UNHDN2u4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b2lCnUJe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 991A660791;
	Tue, 27 Oct 2026 12:39:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zrb6JnaXNvKT; Tue, 27 Oct 2026 12:39:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1206460799
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793104773;
	b=h2V2qRtUiOXBM1Ql0All1kVcK/bBXsPrkBCaYodqhZ3CnuN3tbtBTfdY65jaECCJbDrl
	 xs48218Nj9if7UXN+x+EWI//9tw3+zLYdNfkv/PzJqGjBnLxK5nfwQttlQbDQ77U+alXT
	 Pxd6iOYnmLcFTVibGskY3ucZHSST8Euiw8MGXOkPDKg4osFwrxRsC79l170bi1meJUJX7
	 3G+Gh5D7gvcoUmLM64Hjq08/L+d/cxHiak1F6BFW5eTjLjGNNdQPvDk9/CpzxskTurIf9
	 tWycd5tOIVVN6IQ2JDAar2hTs32GKKzKtBaFllRb48Ld6smyQoytKa+ZuwIVGflPOOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793104773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k9OmIVxEFgnRhOkM/EtgPWQeMK/zGIA7D06xLFR8sTQ=;
	b=J8L8vR/fp2iPuLZ4Le2vaPn4w5JiWXIkwfd91o3Eb3h67TCM2ZlY1UJw2REqLluXquGQ
	 fhWMutEdKR0s4dBLaqdcu7YxClcgPkVxB7klzkxViL/D7UAmo+F1Fm0CTReXJICHXoECI
	 l7ztwzF4EaZEFoqB7khO5kJLAs/gmI+alwyNAnE6U+OGmtYRmi7JwmzWeQl7OI5T2YuE5
	 iJmicw6Zo3E8gJSxQ5LzDQT/hyZuDK+SwQVJ7y8/fsQ6Nk+tn89iNFkEmXWQ1ft4O6bfs
	 KC/chZ2bv7AhMx7AeCM1qcCFY4B2aOxUTzZ9dvML12ZE/i8MoHO7bqHjsAdwIDmeGrQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793104773;
	bh=k9OmIVxEFgnRhOkM/EtgPWQeMK/zGIA7D06xLFR8sTQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UNHDN2u4NWa0NpWgZUmpEkqF33PNEeMhp0CQLFsWJjmx3pKQLyDtjTwuVND9l3o3Y
	 iglO60AT4rqeJHWOiA66xIcqHPIUpRnTo1XAb5hIU7RU54tY1zrArIQn6aYXMmFN6r
	 Glu1kCi5TunpoQZutwnEnWVavSuo8XwBGe4mT8CizfR25ivPRDTHCvc2IJjeRu1Hw9
	 0vyMz5rlQp1ohS1Va+1PIqEEMrq617VE3dHWrG9Werg6W6mxiY+l0mVPAwzrNxTFRg
	 MVFSFMCeDEGc9/tGtgcjoSjYJH2zXvj/Pu3VDxTaQVoNxxoW0LYQz1Rpy9avbJWsnZ
	 wE8KJMIPLO3Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1206460799;
	Tue, 27 Oct 2026 12:39:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 63D7C3D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 555834060C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JX7hbeIFOHrp for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61DE14059B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104766;
 b=XkbHH8ZxP/tXwc+cd4BP7pU3qUURsiUrSYNMPYhvAoG0WQVLFIIc3yubB7ozjkqjBoA/
 BGhrHw/tWGjMGHF78slRa65TNUzyKqDF0SSVUcui6WwsMfDg2ZBZ66sfCAKjU2+v1DVQd
 DZAmoMOBIiEnH98plNq9QaIRTfHDYt8eV3BZRPU035++pA8fOr6i+LVDfKJ8PlPMA31jm
 nmy8+N4mjzkfkXoi1ZpsnMgNsR8r3xuso8LQDuxGkBh10p6AjL567ri0Fkoj9UVHEi83C
 o6GfXy6gwpEGaz6eMAmizxslRynQlGZXxsLKYHGUkuJMBchtNq8fhnqV8/peZ5Olusg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104766;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=k9OmIVxEFgnRhOkM/EtgPWQeMK/zGIA7D06xLFR8sTQ=;
 b=AGAYValo/MLdqHo76Yzzu/AoWD42v4U4xB6E0Kf6Rk6WeLz8TjgAp5jKuA9HjEUJE7Su
 IqGw6F2KQ8ykEq+yxFDMhYioe0kFZJ7ENZHZc3ZvypAlZKhkHG21+edcZuvAgJXof8yJJ
 aybjUGvkdqqbq/KYo3sSY9InFlcWISTGtOVh4NcF9WWUHNqxxpH1A7gTtFFJiYgleNAqL
 q0i46qL0mDSZZp0fzuRVCc402EfSd6izchMWrEEgO7cK/iG9hTL9FIwmgpeoqHc0YJISI
 xSOfFWnpCKGToBD9FrGxHS25I3lp1kpH9xt7qrISAB8n8XWP+PldI7t3t99v7WLHpWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=b2lCnUJe; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=b2lCnUJe
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61DE14059B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:25 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so23387915e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793104764; x=1793709564;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k9OmIVxEFgnRhOkM/EtgPWQeMK/zGIA7D06xLFR8sTQ=;
 b=b2lCnUJeibAyl+L/LcxYJwly98aYxHy54LN3I42yMDFFXdth7YOBGjmAGekNa1NO9q
 F0E9SO3KFaY+sCPY6axkV6YnG4Kb+O8OVzJyglGuSzZucvTqwXsdRzVFXJEpsnRt5aC5
 u3MrTTMVXUpiWJG+RWEV56I8+5AS2dxm29fmyqyQe+/iiYnHWp5Ct2NL7+zP5wXpECRF
 QtWqZoa/o+WgSh+PlOiP9hqX2K6eEf/kHeisse/0Ym16MvmTQMDHIHtThvVtxarR/VeF
 mlou7HSURgIi2kOIjBvB9DqetUriXAI3tnwnnJbM2Rm7FIMn7pj64LV54JgI15jUzhbl
 TfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104764; x=1793709564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k9OmIVxEFgnRhOkM/EtgPWQeMK/zGIA7D06xLFR8sTQ=;
 b=bdIZzzOOsjUTV9mlj402xxUSQ62HC/7guNPZJaA+zcy0rRW63k+w3UiW33/f40tXQe
 IeCP9lAk1y4AMx2DzlfcOt8CacBJi60F2V4qSipNMPZ7shSB2K+hLrNHaUwYZq1qeZFo
 z4SmsuASTaLzeoAEIrIJMWodl6Hg/jhuHMbwQ+/yz4vVfL0XIw9I5G479NYSnnYlSmvq
 XIjfpgklUyZFnRPSDPa0T7V6ztxLQzqUz5PZ+LuhIQZBw8dcNz/T/B2UPkurw92Kl7XF
 4HqYrFDv/zFh777CipiFN2LVb4Yku7mosHS/g7eyxrEiZzRPkpG82yP/B5WA59zbhTEr
 227g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzApj64H2XfTjML3deEPnPbzONHAC+aWdd5u/EyBOyVsp0W5vlFvQEvcevvs9M4oVArFCPqf1M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKnciaTrmzdYfAYK+JN6sIN+jokg0OcOubg+asmSg6ZgwxRPDC0
 E5g5ONGkkxIPdhRsFWoayI7d//HFqUIzdVQQRtiRC9xV55WMFTDi3SI9
X-Gm-Gg: AYBFou1aCtblFXMXHrdhUGg/z0L/2VqnnTPrP1A0TsnQSp+hfB7vD8aamgxU6URRW04
 ZrvQcMNxdd867Yv9SeVYBw9FDvUNKx6oeg0CQTT96Sm3nqJhjGx5z3bgc7YZlcROjlRhhXz87q5
 u8dwOgmbsQbgWqZ/clMv+go+WMQe28FEJc2yI6ur9kCr12Qc4te18uBWs7+1NMV10+Cm1J2s9w0
 Rr3GymnZdUN4VtTmzPoBNeoHZv2+MtxFz56fNR5imeLUokCauGvLQz0xZ1puEE+EIS7xNgKnvi+
 g9V7OzD647vMRKe58AAA7OExsbtACVYnojPfVC7fKNjGobrNxUbM2UPZGvySl8I4t4pjQZYxYHO
 zKXUy0X4al6XZ1GJ7zwoe6m8EyKXdOVn1PslspJBlI9xIgcdGbHpf0xJHRnoAutNNhtMTtj6FV6
 8zEl9AhW5GZyL6enkXib+tYutwVkIntzMtdv4wicF4Pm92dmPkmN/kh+luoM508OwR9VMiQY7X4
 ydb5WUOj/1jHKUySzWtlLmB1j1B3nP+ua9DEkNFkCFIhuldzr76YhKNuFbEYMsNWG3kN2Zt/R3P
 QOBI1QuLWtDSIt0KuuQM3iggNHX38POcQGVZQ3Jn1TZcyME8KuES3FaWy0qw5cqEU5jij5pQoHn
 7M4T7yg==
X-Received: by 2002:a05:600c:8183:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a35ac99b77mr161869015e9.9.1793104763642; 
 Tue, 27 Oct 2026 05:39:23 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm29142078f8f.49.2026.10.27.05.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v11 5/8] misc: fw_loader: implement request_firmware_size() OP
Date: Tue, 27 Oct 2026 13:39:00 +0100
Message-ID: <20261027123905.839-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027123905.839-1-ansuelsmth@gmail.com>
References: <20261027123905.839-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It might be useful to get the firmware size before reading it to allocate
the correct size. This is needed for case where the firmware size change
across different firmware version and is not always the same. In such case
the only way to handle this scenario is to allocate a big-enough buffer to
read the firmware.

To better handle this, introduce the request_firmware_size() OP to get the
firmware size before reading it. This way proper buffer can be allocated
and dynamic firmware size can be better supported.

FS loader is updated to handle the new .get_size() handler.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c        | 28 +++++++++++++++++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c | 19 +++++++++++++++
 drivers/misc/fw_loader/internal.h         |  7 ++++++
 include/fw_loader.h                       |  9 ++++++++
 4 files changed, 63 insertions(+)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index cc1bbd2f0db9..b7ba57ce6778 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -190,8 +190,36 @@ out:
 	return ret;
 }
 
+/**
+ * fw_get_filesystem_firmware_size - get firmware size.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+static int fw_get_filesystem_firmware_size(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t size;
+	int ret;
+
+	ret = fw_get_filesystem_mount(dev);
+	if (ret)
+		goto out;
+
+	ret = __fw_get_filesystem_firmware_size(dev, upriv->name, &size);
+	if (ret)
+		goto out;
+
+	ret = size;
+
+out:
+	fw_get_filesystem_release(dev);
+	return ret;
+}
+
 static const struct fw_loader_ops fs_loader_ops = {
 	.get_firmware = fw_get_filesystem_firmware,
+	.get_size = fw_get_filesystem_firmware_size,
 };
 
 static const struct udevice_id fs_loader_ids[] = {
diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 7f19d6c4af4c..4e67f2559fa2 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -210,3 +210,22 @@ int request_firmware_into_buf(struct udevice *dev,
 
 	return ops->get_firmware(dev);
 }
+
+int request_firmware_size(struct udevice *dev, const char *name)
+{
+	const struct fw_loader_ops *ops;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, NULL, 0, 0);
+	if (ret < 0) /* error */
+		return ret;
+
+	ops = fw_loader_get_ops(dev);
+	if (!ops->get_size)
+		return -EOPNOTSUPP;
+
+	return ops->get_size(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index 9ff43e872554..1abe7504a81e 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -32,6 +32,13 @@ struct fw_loader_ops {
 	 * @dev:	Firmware Loader device to read firmware from
 	 */
 	int (*get_firmware)(struct udevice *dev);
+
+	/**
+	 * get_size() - get firmware size from Firmware Loader driver
+	 *
+	 * @dev:	Firmware Loader device to get firmware size from
+	 */
+	int (*get_size)(struct udevice *dev);
 };
 
 #define fw_loader_get_ops(dev)	((const struct fw_loader_ops *)(dev)->driver->ops)
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 99c47380a172..01f242dcbefd 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -38,6 +38,15 @@ int request_firmware_into_buf(struct udevice *dev,
 			      const char *name,
 			      void *buf, size_t size, u32 offset);
 
+/**
+ * request_firmware_size - Get firmware size.
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+int request_firmware_size(struct udevice *dev, const char *name);
+
 /**
  * request_firmware_into_buf_via_script() -
  * Load firmware using a U-Boot script and copy to buffer
-- 
2.55.0

