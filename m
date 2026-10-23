Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17422606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lRjic3S9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kJMNr9/V
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C963A812AC;
	Fri, 23 Oct 2026 11:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8AJnOrvaLA7; Fri, 23 Oct 2026 11:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E06FC8129B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754177;
	b=anOKQuoUWrlEnz8wWe3Q1/0Dnc/n5Vp08u/lViHu0B2bYPN5oYnyRN6AopQWlrlv/PtV
	 bAQpbqFNxZSiomUNxUpA6vamh0ofCliaXRGFU76CH7LnXs2be5B4xm9jI3JigMPU5oQMk
	 fj0rvHPsqtNHLAc7htVP8Fi+KKC9vpJPy7r9z0dSC09rKO3YVETk/uT62HSWPkmyG9fpt
	 E+DKTyWAW1xLekc07mSd/VU+xCC8NCHHKO67R9OFcZBLWI+8bymTlrc065INmVOqEx7rx
	 zWxHUlOrfEVOI0GavzDylKvcymCK+pBh3DK3BpCMbxFKXPd1BF0e3LgQaP7tjeLi+OQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=d1adUj5iTK1dwJnHsuKwgbw+NKZWcWW8GrM7m1TOcEY=;
	b=cZFpOaT/kw4qoCgBlaqrUlJETtJ+app9klJrpQVcAsfV9u0TRkLdQWWIyw+d/c9OXBXb
	 uUTRF5a2vJ38xSXdgoX5k6UXaclelbBRzT9C9VTT2HZJr2UlV01zK9juHNbxMAjTgu5ET
	 mcP86JgxVUKTCEIClu/MAfQLAyTINPAWLCvlkYwWCsbVmSpBmmveM1s23nOE1q0VNcsRR
	 A7K+9lrNBvorj+kmXENrEc8CKcp78vetjDpXHPzn/EZGemstcQRRpy1GL+YZXk8vga92t
	 vjaKQwTLQ9eLNvubs/mUZqDayj6sKD9J0zGvrc4QWuzWU+JeFklRpvXEyc2czoZBBGg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754177;
	bh=d1adUj5iTK1dwJnHsuKwgbw+NKZWcWW8GrM7m1TOcEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRjic3S9AMsmFZQFuy6HvRftzJt1rci5VWPm/VV3gPZJb+G/Pj12XS4B06CHCCZdR
	 vdhEl5dcEuU+Kd+dSlpVkzOCf+1tMjdcwFv8nObSi/0MxnUFvMbxPWpj3nvRP0lNlZ
	 vl6MdIASYUANDosVJSyfUIPRtjMb9H3VxPuibXL8rbj0ejGEtuaGDQ97TmnyBWflff
	 W5j8MKnmXZygzQCtrhJn+k46QtEFHeAx9VN0Ee147oI6Y/IC0x3qaldQYq4viO/tVU
	 b61zBVdWaCu0r3xDh0BT6gD6aoCRILL71iYWiFkn+qIoYBXhPL3E4ttfcpg/B+noqP
	 vOcol4XCnXEAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E06FC8129B;
	Fri, 23 Oct 2026 11:16:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B223B2739
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 956CD606BD
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDtFdYlYtQ8t for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D5206064B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754168;
 b=RiJmB9BC5vGuVNB+c4hVT5xCk35NeD8CjVQEqru1gnGq7GFyo97SCQZD3OWh97zqCf7m
 2Iv64cD2IKwwxtVk1bQOWQ7fsKiK+I5ALy1K7DtPFpDAkHKvTcGC4is980u/16iQ0eJuK
 JhA8UBXCwToN/1En0PXLbD1A/jSHCtKrbY4IPpE+zadiTNtZ2ceu2r5AcAD9SO+dLyKU3
 DrBEiOr3pbb3p+WimX61sGGe3cWRQnPj/PbIcZbRpOxQZIzlPABAApXpJf2ZCNDA+j+D5
 DOZhaxXiDGmPf/7zOs0gcOusOwpzq7gVGmXfMCufFjxyauK0iwBxOy0kJ/CgOob3S7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754168;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=d1adUj5iTK1dwJnHsuKwgbw+NKZWcWW8GrM7m1TOcEY=;
 b=nD1MRymiiHBehpqYsmjpkIVbLhxNLZq3m0MmAytkcShdlM7t5diP1Vfuq8IaxtUrEjPF
 84ALTXZ1EZ5DQ8IF1ByJweF5XNVp+/S+JcP5GVpxF+6yl55ixsflOdWfOrJHiLnEjCSOL
 0MOYEYy9XX9rJqPHJL9hSgJvH8TrhJwYoTTPON4fOf53hup3vJ9k0y3IyzTP7hq/Wfux+
 fzewHpDbnuNFgGD0pRrXpbj8quZS3Xp6tps6bjs4Xxw4H5LGOG+7EdqTZgp4TXTCxsaCq
 IhBQWok5pdH6FcsvdmyxzgjauwF8DYvNlRsEbN7ftSc+cHepMAvuwtmIs4blr35HArw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="kJMNr9/V"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kJMNr9/V
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D5206064B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:08 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e04773687so267561f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754166; x=1793358966;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d1adUj5iTK1dwJnHsuKwgbw+NKZWcWW8GrM7m1TOcEY=;
 b=kJMNr9/VsW64AF8omlgW5/YzpGc5nH9TdQCUHpbWCfj3hY36kyHIjMc1lFMQomheAh
 WMkm1yqIAxWaYB0HQklcwTlV33AAhLVL6L3euPzqBVGnbL4OH1EBT5SiiV+MII9Q2N5K
 WmU6m9dwOZ6J0Kg3Ng0UkcFi1wDCIRgje+Z1XH9HcD0u+rZx0iJHG1EvDGfkE48y2PUc
 gXyiLQdjZL9CT43hyQ80ptHUnQCtEZ4jqvrLZxcLjtVW87fdGO71lLNEnheqPe/1mvu/
 hRw5gMKVXT4Ljjp0hMp67iyeesbbx01NERCpcq2j7YIlacNUNUB5IoovmxtKbdh8JzUk
 r7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754166; x=1793358966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d1adUj5iTK1dwJnHsuKwgbw+NKZWcWW8GrM7m1TOcEY=;
 b=LzmUZ32XWANMxZhObdYw784SO0efifwZD/PbQ/Ct1/dq+KGZs1xr1SshDknUrwQEgJ
 ceWUZaxVlD4STpuE0og425FIWDAdfkKWJ9kuZ/ALDY8OWgcT7d6YU0PpXS1B+JVvi0gc
 zLLnZAD7LFwaCLIvIt4mRm7bklS8REpvrKnvVt2ZBf0fcmWiCxpK+d3sOhKP1hXE6fLs
 cwVn7HypBQ9GfnnunZ6aWz4a0izrGXzb3FyIFiLUUYFE81YOFl6VmcTi5c0o5lCsmbS/
 ieXh1n80a/7L+wkUQYdMXjlCmylPv5AEOlvDv/LmRHh1f1WdT1r/o2REdA68EmctectV
 guvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMH275jnSSFiQP7MD/mJ8Lz46q1ynFYVpuwpwxdgoUqSOytjr2Zpvml4eqWuGVphjKQu31Mgc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLZz4cxKUK+tVNoXjnBviqV4F9UWIs2wSDj6wL0Q+qaXDAt5FQA
 L2ZTCDb1KqQCBIGEtCZDPm/R3+c9nLvFgn5XNkQ8yxVCBOBHRhOCZeq4
X-Gm-Gg: AYBFou2F5NE7Co+uRJQFNIGcEJGjhqiyCTnRfMKCMEIGXqzMlSt7occsxCjuQzU9gl+
 UJA5mNjPJd9t8Up4pleIrt9mCOHivTUqfYjZ7QdUOsKrI94HcGRxITQHTkpalvN71kn7pOn/iKH
 s67kJOSScNAV+LsEytXB5Az/tr8VYZLSvFWz962R9rzrroxJftflTaxkvGK9u7TNNoD3voyvcQm
 YtP5GJSZLHC6QCCxm10gPit+hoftnAlp97+2pPEoj9IMFl3qCml8rsI8cY4nmxwtbnGB0/2gB/o
 8TZgDyNLqzZ5FJVHY+pRKpSU+x4g4I5ulIPUAWHW2QHTDut2yD34l61saqDB55sdQ9vULG0yaSi
 r8fUX8EsBDdA5jsu1NcLG1xUxpmqgnE3AVd+0AYNR6JayY+hOJPwu8Fwj6NniAcai6nHoQhRN6O
 yu2w1RUDO4peU2f61At7XgaKMxb1uTMCbM2AFfhduC2eKnfVdfAhnusyeo9cuvLpKOJgL2kNIza
 hWZO4t4P2wXbHYpgLUn6gc/nxJinGltcV+61nkqKFC9BrjMuEjCEXQAd6ZzHhQ=
X-Received: by 2002:a05:6000:98f:b0:48b:1296:52ec with SMTP id
 ffacd0b85a97d-48e385ac43bmr3064004f8f.18.1792754165854; 
 Fri, 23 Oct 2026 04:16:05 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:04 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 3/9] usb: ehci-vf: remove the code path for a build without
 DM_USB
Date: Fri, 23 Oct 2026 13:15:53 +0200
Message-ID: <20261023111559.4081795-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023111559.4081795-1-mehmet.fide@gmail.com>
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

USB_EHCI_HCD selects USB_HOST, and USB_HOST selects DM_USB, so the
!CONFIG_IS_ENABLED(DM_USB) branch of this driver can never be selected.
It also cannot compile: ehci_hcd_init() calls ehci_vf_common_init() with
one argument while the function takes two, so the branch has been dead
since the controller was added as a second parameter.

Remove it, together with the board_usb_phy_mode() hook that no board
implements and nothing else calls.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v9:
    - none, rebased on main
    
    Changes in v8:
    - none, rebased on main
    
    Changes in v7:
    - Reviewed-by from Marek and Simon
    
    Changes in v6:
    - the commit message names USB_HOST as the option that selects DM_USB
    
    Changes in v5:
    - none
    
    Changes in v4:
    - none, rebased on next

 drivers/usb/host/ehci-vf.c | 49 --------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 32fe05920d0..5d27318de62 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -128,11 +128,6 @@ static void usb_oc_config(int index)
 	setbits_le32(ctrl, UCTRL_OVER_CUR_DIS);
 }
 
-int __weak board_usb_phy_mode(int port)
-{
-	return 0;
-}
-
 int __weak board_ehci_hcd_init(int port)
 {
 	return 0;
@@ -155,49 +150,6 @@ int ehci_vf_common_init(struct usb_ehci *ehci, int index)
 	return 0;
 }
 
-#if !CONFIG_IS_ENABLED(DM_USB)
-int ehci_hcd_init(int index, enum usb_init_type init,
-		struct ehci_hccr **hccr, struct ehci_hcor **hcor)
-{
-	struct usb_ehci *ehci;
-	enum usb_init_type type;
-	int ret;
-
-	if (index >= ARRAY_SIZE(nc_reg_bases))
-		return -EINVAL;
-
-	ehci = (struct usb_ehci *)nc_reg_bases[index];
-
-	ret = ehci_vf_common_init(index);
-	if (ret)
-		return ret;
-
-	*hccr = (struct ehci_hccr *)((uint32_t)&ehci->caplength);
-	*hcor = (struct ehci_hcor *)((uint32_t)*hccr +
-			HC_LENGTH(ehci_readl(&(*hccr)->cr_capbase)));
-
-	type = board_usb_phy_mode(index);
-	if (type != init)
-		return -ENODEV;
-
-	if (init == USB_INIT_DEVICE) {
-		setbits_le32(&ehci->usbmode, CM_DEVICE);
-		writel((PORT_PTS_UTMI | PORT_PTS_PTW), &ehci->portsc);
-		setbits_le32(&ehci->portsc, USB_EN);
-	} else if (init == USB_INIT_HOST) {
-		setbits_le32(&ehci->usbmode, CM_HOST);
-		writel((PORT_PTS_UTMI | PORT_PTS_PTW), &ehci->portsc);
-		setbits_le32(&ehci->portsc, USB_EN);
-	}
-
-	return 0;
-}
-
-int ehci_hcd_stop(int index)
-{
-	return 0;
-}
-#else
 /* Possible port types (dual role mode) */
 enum dr_mode {
 	DR_MODE_NONE = 0,
@@ -372,4 +324,3 @@ U_BOOT_DRIVER(ehci_vf) = {
 	.priv_auto	= sizeof(struct ehci_vf_priv_data),
 	.flags = DM_FLAG_ALLOC_PRIV_DMA,
 };
-#endif
-- 
2.55.0

