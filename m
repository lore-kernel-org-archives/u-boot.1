Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3260A3827
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nJByXXuF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wv/dbmE4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDE4860774;
	Tue, 27 Oct 2026 12:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xkiwEKYcJbAv; Tue, 27 Oct 2026 12:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 706616078F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793104771;
	b=BIwHRdL/YCE6w7YtcydQUNFNxXjfZz5+/UXwi7TSqP5cfmxhOYWmFf4v/1XVTh8f/bx/
	 BeSfq0fhOWlNPXoeMun7DU2rQvS8XW/0OGmzdiSsc1z8rRa1ses2FZT57V4ywcOabIMN/
	 th1+tqHHWbSamSmPhr2CrJj3tqVtjCFsOjFJOhivkRtHLZr91LsI0M2WltcrI8/u3kzD/
	 fokxDald8bnVXTATolxWGCcohvSbdOkaHZSCa7PgNHiN7Ijtalrisxy/21egbKtj0OfiZ
	 AJymq24bscLMBSYZDX9d6as2yrZO4WeszIm/+C98kUuYrGIt8xNXqPzAXx7xREOaFlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793104771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hK+tJX/rg33Tok3Vlrjbw/zEx8N0C1f0uwasv84qVYE=;
	b=NfEvc+3wlkDuyGeblX3PIJH0dh9IULEKAZPDNq7n2qWnYj2JcpLBFJuRmlYq/bURNaiW
	 29+vN+yTL82NRAd6s5s8Ok0nyo18Lvw+I26cw3iz4ikYVunuW4UB4LP1dvzMpXRLc/mF0
	 YqZP6lvPZJW6fJLIGQ87JYsuu/gVS3vAi7VlJFIBl+OtgFYEQhVkNkUkK1GCpugHTQ3Kd
	 WBUNa6Nqy1edQvmoy9DKrAcK5PmDvV+lRkvnTqg2m/cn2n50uvkt6l7JSJzEbvzaNfM7w
	 GDWN4CVScf66W/tBxFb3yFnmzEXKzjLPIJBZP1Fg88pYSWZbVspYGL63EEYImsCzqAQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793104771;
	bh=hK+tJX/rg33Tok3Vlrjbw/zEx8N0C1f0uwasv84qVYE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nJByXXuFRg2Uz+EthRm2HDX9CxpZsXG7zv29rCdTNWKUWsSMPjqBgAbY1EBbelWoe
	 vjJjmqv/hDegDvUZEF32s/6pFdmR6vigDeYCkgLDv8j+M0p3NpZK30K0+HtRQ4UGo2
	 pOgjJX9zVFciKRREIfmszC0kLPiEM5eCbH3CsLRXX/NDiiaJbUdZC30NhYC00RNptI
	 A/9NeOSliZOkpBzgdHCyBwXAPlcfDgjRHHAlCV00ZA/7hNRxaHu84XYoi6dG5kuxq9
	 /+4jqDhM41yUXIMDjG1oCXdc6QMrHogHHUODi/wTc+F1vxQaIRUiqTm+NE1XmjQDJv
	 jqcc/CwpmYIhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 706616078F;
	Tue, 27 Oct 2026 12:39:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CD5B3D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A41380C0F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bLjh9aFPiVWU for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6633180AE6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104764;
 b=dy3tL+0OGIh9VG9zsLZUyqa5MH4z3RjTdrKa5r9wER1D5Gj8HbkJIsw7IwoJ3zriQH9C
 0x3uCQA6hyuLEtFoi9H7C2/X3fyB8vPJTjD+eKIEy/+i1q3xXMrZ8hz3EBWbOKVpOL3na
 IGYWXprNRyBI+iVBmr5VQsFi8agj7+rQRhujhxkVeDXP1UcPNmwZhDAokPobLPl7aOE6/
 kEeSFFhnKqNClvUgSevkJ0mXA5w+GqrrTu2bX0g42BBo6u/wVP7tX337RVXYoW2XeeP65
 y1PNVd9Qh7Fm6+FVh4Xbvaf7RkaHdMeUS/RZoKo5zl55dAexhCwZ2yCe15jPlyJ06Kw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104764;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=hK+tJX/rg33Tok3Vlrjbw/zEx8N0C1f0uwasv84qVYE=;
 b=eAbPMpoIY7hkyhArYMuyIKofXxFoc1Td0NUVV/BLAk6mzwxwZTYUag6iPZFvkKR0MC1y
 Kg3Ear1fBfHqNB2gN9w/qk6oo8buRgb0Pz1DgODu63cWdrleUy4HWbBvUHNsSgtur4Yyd
 pYF//MslsRD79o51JxOA+gJOeGbcd1PLqMdv9CDDUIVF11bGprKUnO6mOG+ncD9OijZJW
 c2FJazFf1Nsue5OplReDVOfxfWq+yOMm3dNOdD3YixT6mDbRIwcg0hiqmxmJgCUl8O0g5
 2kudqPYtkiwTs+rmtlxPHnU6T/5mFpQUjO7UMpPOpOkFYYFR1nBeEKkizOR0SqevuQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Wv/dbmE4"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Wv/dbmE4
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6633180AE6
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:23 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso41867695e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793104762; x=1793709562;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hK+tJX/rg33Tok3Vlrjbw/zEx8N0C1f0uwasv84qVYE=;
 b=Wv/dbmE4+EVrfVrSVLm51nwH333vemhLhWv6jDQsyOip5kojAPbm9RFq7BkkDN7v4J
 VWMCYYUAD5ZdsAH9+Z+ekUPOZLYyQwO5qQkgyy7lVJ6/x+Ied943HJS3WBSX8Hr6DSjn
 BfPoaHrSAfSQ8cLf78jwhiNR79irvUgZ14guMDQkyrWqOFcOpJkWC/154Qql40UG8hEb
 EKZcLMk6fOLX51e0QWQ0VwS5K/fLyVDJCUM8gKjqDIk/pJ6WmegtxRxrkp7tlLGs2MCd
 xnkfkzg2n6Dytbjl+e+XLtpzvLTdKENwcvDDcHnO7YGNveYTawm7VhEbsCjYknI1Kym4
 cjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104762; x=1793709562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hK+tJX/rg33Tok3Vlrjbw/zEx8N0C1f0uwasv84qVYE=;
 b=24QGQNUeQajhIASsVij0dYeMVwG0o5OUIRZycE4NULlfMnL1DAM4igkodulxzMQLpE
 QggKOJjXGRaTxgjFvQHDzr0C2vY7zFxdSv+98PpUdXmK6YvNgOqblet+vixY5WA/5O1E
 aFrxEsvy3SKH73QPqOEVrtZO1W0cQrwlNGaF681aW6xLdlapQJqIbFYKf0kncadx5sia
 e+rfRQ/G6K98W8IN5jFTkwpbMKBIhvQkGfYtVFT/OK2ZU9QXptOcdrRwEPYJ/YwgLJkx
 O2AokvTdNqN5IZRT7WuPqFnjOFJKEPyELJ3+OBiWFZ/OUjBJDD1n9W/H/pXfcYJmpD1R
 7ICw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNQ9nkXUceno+D/FB95dZPaU3CExDRR/shPeCgjdZQR+vCkuz6ZMjXWGrXsUkQWI6qnRP4GWU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLyo0DhcME1i+/OB8/4xQPPq3xqg43mBvK4F2wtOYx8dXMNB4QI
 v+aZq27bfMpJNq2oUAoMDEgvN+UpzrOFjozsaaUpFitRDqLRIqAU+erk
X-Gm-Gg: AYBFou1Q3edv4xXKRhFFPOOE9AursrMMqsdZR16t/h0hQ1fDaqlFcVw470S2ez1ECVZ
 HIk0frRNERw/HEzbAEnWAjTyku0H7LqrOqYFBWvC9HR8B+5WUaTYVDU30AUbdNkHhmKEQOFeVrx
 ajWDnt1LuQVUxAMIpP11UdrL8w+jhBvG9viXpeeXT5Ra7E1hBD8lCuUXacA+1+fJWIzY3yAk4vv
 j5RKSzrW2rMCnsKTfeRrjhXrzVuvrqIJv/ungVuMMLFo3Fpo3PjeZ+j4+oEOZaT5K/z0fRx4QdI
 SWKYs0TGzLAcFq0FxyntuGbsJSg3wB2UhLyCIYstVfIJA66TpknM+Nmv+o5M17PkEJgvTUzEkue
 7VTEf9NqaaFuGaAg3GSB13rnadhWXP1DmuHSW6h84QE3KBCxqIU2QnbDIF+bik3Ovv3H3hI5GWk
 eE1ASGWgGD2Mff+31OyZlqgQhSPv6FWowHoLIm+dn8rQ45WNok0myMex83uNtZ6Xm0IqC7oUF1P
 Qdy+O9W92Wf9eo3seI2GsREnxTL9tW8XQF1izvfui+pi3FPE4slyfJV0+lt1YppFQv/j7kN5Kfs
 OYU16h/2axlQQuC2rDcZ7mHhbpPmrK+neCoGLl/usMI3Qth4LRye1V0fWqPv
X-Received: by 2002:a05:600c:4e43:b0:4a3:5991:719 with SMTP id
 5b1f17b1804b1-4a7776698f9mr74066185e9.31.1793104761818; 
 Tue, 27 Oct 2026 05:39:21 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm29142078f8f.49.2026.10.27.05.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:21 -0700 (PDT)
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
Subject: [PATCH v11 4/8] misc: fs_loader: validate requested offset on reading
 file
Date: Tue, 27 Oct 2026 13:38:59 +0100
Message-ID: <20261027123905.839-5-ansuelsmth@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make sure we are not requesting an offset for the requesting file beyond
the size of the file.

If it's such the case, log an error and return -EINVAL.

Code is reworked and split in various subfunction to permit re-preparing
the filesystem after a fs_close (called by fs_size) and reduce patch delta
of upcoming support for reading ONLY the size of the requested firmware.

Dedicated mount function are created to mount relevant filesystem only once
and follow the same if-else logic pattern used by the prepare functions.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c | 97 ++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index b1eb0311dd2b..cc1bbd2f0db9 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -49,6 +49,16 @@ static int mount_ubifs(char *mtdpart, char *ubivol)
 }
 #endif
 
+static int mount_fs_dev(struct fw_loader_plat *plat)
+{
+	if (plat->phandlepart.phandle)
+		return 0;
+	else if (plat->mtdpart && plat->ubivol)
+		return mount_ubifs(plat->mtdpart, plat->ubivol);
+	else
+		return 0;
+}
+
 static int select_fs_dev(struct fw_loader_plat *plat)
 {
 	int ret;
@@ -63,10 +73,6 @@ static int select_fs_dev(struct fw_loader_plat *plat)
 			ret = fs_set_blk_dev_with_part(desc,
 				plat->phandlepart.partition);
 	} else if (plat->mtdpart && plat->ubivol) {
-		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
-		if (ret)
-			return ret;
-
 		ret = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
 	} else {
 		debug("Error: unsupported storage device.\n");
@@ -79,18 +85,26 @@ static int select_fs_dev(struct fw_loader_plat *plat)
 	return ret;
 }
 
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
+static int fw_get_filesystem_mount(struct udevice *dev)
+{
+	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
+	struct fw_loader_env_info info = { };
+
+	generic_fw_loader_env_info(&info);
+
+	if (info.storage_interface && info.dev_part)
+		return 0;
+	else if (info.storage_interface && info.ubi_mtdpart &&
+		 info.ubi_volume)
+		return mount_ubifs(info.ubi_mtdpart, info.ubi_volume);
+	else
+		return mount_fs_dev(plat);
+}
+
+static int fw_get_filesystem_prepare(struct udevice *dev)
 {
-	struct firmware *upriv = dev_get_uclass_priv(dev);
 	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
 	struct fw_loader_env_info info = { };
-	loff_t actread = 0;
 	int ret;
 
 	generic_fw_loader_env_info(&info);
@@ -100,10 +114,6 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 				     info.dev_part, FS_TYPE_ANY);
 	} else if (info.storage_interface && info.ubi_mtdpart &&
 		   info.ubi_volume) {
-		ret = mount_ubifs(info.ubi_mtdpart, info.ubi_volume);
-		if (ret)
-			return ret;
-
 		if (!strcmp("ubi", info.storage_interface))
 			ret = fs_set_blk_dev(info.storage_interface, NULL,
 					     FS_TYPE_UBIFS);
@@ -113,6 +123,55 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 		ret = select_fs_dev(plat);
 	}
 
+	return ret;
+}
+
+static void fw_get_filesystem_release(struct udevice *dev)
+{
+#ifdef CONFIG_CMD_UBIFS
+	umount_ubifs();
+#endif
+}
+
+static int __fw_get_filesystem_firmware_size(struct udevice *dev,
+					     const char *name, loff_t *size)
+{
+	int ret;
+
+	ret = fw_get_filesystem_prepare(dev);
+	if (ret)
+		return ret;
+
+	return fs_size(name, size);
+}
+
+/**
+ * fw_get_filesystem_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_filesystem_firmware(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t size, actread = 0;
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
+	if (upriv->offset > size) {
+		log_err("Invalid offset. Entry too small\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = fw_get_filesystem_prepare(dev);
 	if (ret)
 		goto out;
 
@@ -127,9 +186,7 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	}
 
 out:
-#ifdef CONFIG_CMD_UBIFS
-	umount_ubifs();
-#endif
+	fw_get_filesystem_release(dev);
 	return ret;
 }
 
-- 
2.55.0

