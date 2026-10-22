Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29859606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nI9v6fBe;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=E9iVuhVN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E145E4091C;
	Thu, 22 Oct 2026 14:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RP6mabqbMvsd; Thu, 22 Oct 2026 14:03:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D04D140800
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792677813;
	b=kN1oaeveZ6Ou3TQN/P3MtCA0rDo4xWpI0FwDEMF4IG47NuW7c94T0oFB4oeVRn5YgzGX
	 ENxoiLpx5P1p6eM2rB7tl4XkR2cOrQz1BV/SCaCa48+vch6pw0RPlxguyamsWchavii5A
	 kuhtzjKAkCw39qlcdrk8+gbXIy23dYsAAC6M4Yn4frjL57hrm7Kb5IOa5f2VXzLifWVjF
	 1craRt7d7c7S5LKHi02VMnHoZ9Idekmc9Z/ubGiO63rC5zScZPAu2H0gd9eyTMePE+w58
	 Y0+qhfLQ77d8hkivzmwsZ78aqboeTsgD4pvtkZOqgpmNkZyXIOr+LybaqNdadcWcp6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792677813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mcQfB5ujNvwSeXVgy9kNk3uclEW5oXlpsz0MODN/sNk=;
	b=AgUkYDs5jRL9cnaKI2Bc0wwD+rmEkXFCGI3sEsK+UvGwxfTlI1voR6XUn0X0ZSu5hDdB
	 hAWJGQrd2/2bMVXU0WfceCy3cJzI3XIqMxzUfxTg40dsNqDfV9dhryv4d1Bnb33IjOLnS
	 Yqdgp1eeKIedj2r8MCQsxh5UENiKb53GW9888rybjF/SLcd226UOwxRj5/Oqy0VANBKX5
	 auTVyejPJtQZnyJDwFh/LrkcMyG8x7MfiRPv2wWgGAb+qfU7qliyRoJT4Isme+RFFEK58
	 C3SQYOh85VbzTU84uOLihJ37NfAu/k7s4p4KQ9INrfBPRsuCFmGSOYPs9mCIobiBPWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=E9iVuhVN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792677812;
	bh=mcQfB5ujNvwSeXVgy9kNk3uclEW5oXlpsz0MODN/sNk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nI9v6fBeJ0cMT75Naj/A3p2htBv3icanIazlYyt+uxI7WR/MuN4r1c8CP3rN1YI3N
	 e+6JSRM3FGuzadz3pYBZxvitMm/5eozeyYawI4MzZ4B7KUkygfcKtfUEFuE83x0w9h
	 LSNSXZuc+bx+UUL9Tynf6V3wq0dE1hayrvFu0iN5zHdtYYCejS+EKiw6bVNnS73Jtr
	 85nXe9dKjZnvp0aWR+llLOom44+ZOK+duhVLfqrFP/X7CPrXrANcrQ4hFf/77mmKYS
	 IFH5hABXUqn4tupwnijd6j/iFtgCWsb3wfLYPyitm7Jr34q5RFRYhCz4bw8mGMniG3
	 OnO2H7/jm2Ndg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D04D140800;
	Thu, 22 Oct 2026 14:03:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 399563AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3543F407C3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJYbCEad0TI3 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B155D405D1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792677810;
 b=YwYYHEi0iM+AYkIrxNQFXtF0xMOT/1I9EXMTQGQEt/fy8RUQ//20h0sGRIhUqDTSDrQp
 i46mHreevoDUh43RIExthVgv48HpV0bwHT7j/zvkPXdZyXXdsa6XxsruU99G4QXTZ/9Sp
 Mqtafyeu7R9UWaL3NxCcg8bBLiq5UpQbWPPDzge/xtoGU7Pa+oXHh4zMqhBpMU20tFkqF
 IQMPSXPG6NmbztbKpR2RsAP+hsoGcnu56DgTVMvr/0wvLPjE/kxtlYZ4XvxLwghvnJ5vz
 5CpP/orocvQL2JJCP55+xz3SOtESmbkyWdHypUmjNOJtp2UUYSVWQ5nzFG4Wm47o8mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792677810;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=mcQfB5ujNvwSeXVgy9kNk3uclEW5oXlpsz0MODN/sNk=;
 b=IBV2EuuDcZTkLZMnuYG6F6tdZmGRccoXcLFLXdCBARlwbtRkDNJNZ0/4zLMMD16inmQ0
 K4LHzj9Q15bVKDlS9r9emnlJlKOmjevofE7hU/AhLOoAQq8axhbfyLHgQUHYLQ5XEWTIj
 +qlsF3yf7+m4S4+UqhiyI/W/MB4eGukRE9300ASLRnko4NInVUboJsn4CiOKwyhzcfsZg
 cEC/cfW4aE1ZINYRhcb64xOKNe0n0wfJmXFOuPbJ116pgpMwXUbD8tDWyJThaNd5JKeNE
 W+qc1Ho89uibVkZZ7OpyIyb9ubqCd8wWxLpSBQMVwckd3MNQkNTfHIWLcH7aVvm+4tw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=E9iVuhVN; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::6;
 helo=mail-wm2-x06.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=E9iVuhVN
Received: from mail-wm2-x06.google.com (mail-wm2-x06.google.com
 [IPv6:2a00:1450:4864:31::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B155D405D1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:27 +0000 (UTC)
Received: by mail-wm2-x06.google.com with SMTP id
 5b1f17b1804b1-49b0dd21eb8so4171815e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792677806; x=1793282606;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mcQfB5ujNvwSeXVgy9kNk3uclEW5oXlpsz0MODN/sNk=;
 b=E9iVuhVNJBBjxZzj0Yr4pVXoKe/z1M1IIwn/AlmHSCf/KC/YLCofyowdbwabOCrR2S
 G+lkP6c6aWKvBO+yldz7iRzGgqgTqUbMnDuS+uVuWkla1+PzGHjnJS7HKkl5N3BlS0Xv
 hEEH6ZHVpjVn05FBE5ulqmkOwc+RETv+j8/ZXB7C2Ull9299QxkCdcN4fz12KkpQAKiD
 9c8fukVyprh3RNdCzARh56j6MY+4YYvj1jEId21Z5uXc9ENkUJuyNfYrc+O/aOm0oohf
 IL2pu/V27mP2iG6KMecldOTmx7SKoJpkDSByIy6HubDWfkefh8lH8Jx9sFHw7LqkJiai
 W8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792677806; x=1793282606;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mcQfB5ujNvwSeXVgy9kNk3uclEW5oXlpsz0MODN/sNk=;
 b=TTfExEx03DWZ63yFQnplIMd+8m44K06a8Kd34SxqRJxzxaJ2P+3ola8RiZKCYD1NEc
 P51BV3V5giByj+7iymwzLhEAkcRD+2tRaUFnWRHbbMv/eLXLzmbuQSP9prd44GWvirL7
 qhhDZx5SYqnLSg0hlf3a7EXmu0QU3cPrug+O83toWCulKnRl+RVKaD245na7HI+MzS+N
 AekPIDfoXZUuL5X0KTtvgpXfjad+XKNRPNC8fiPqtZY8zd2f61iZPvRKvagVPhLyJ/4U
 nYYK0mUeEevumMUGhWo6CbacKL5iP5E8Y5zCssHp5Xmrp4+qe2//MfncpteTidUQIFVo
 Ah7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXQYww5BLI0AzKLoy/4BBF3kqkd9/pJW3ZBDbkr14cW9++BQsCWTVZT56onHlXLLH8Q+I3mhY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLXRH/hG9MvPREl3rffUHOAiuxdVnWywDpt//aRlTY1HXIMK8oT
 NGh0KNzdwPiYLNJEzj1GxoOkVQotYLkXQk94tAWOjb8B/qiYpMFv2quWemZgW2hFvVTl5Mah78q
 CPZvA1+lkgkz7
X-Gm-Gg: AYBFou1KJvX02Q0oy+RXdPzycS9LwsjvgZ/XT0aXiIW8a1sDCwdbQ1Nul8AuLGtxWPe
 t8hQLv8zwtG4RsiiTwp6xpRWj01AlsQ5TV7f9A8y0uW/usIBSIoaIMMrg/4ecH/FUD1Ms9gtjcE
 B/OpJNzBjWA83X9xIGPbUKgPo2n2fLvd9Yf739uee7uTZtWaTZe3X5dBiyNBqIApbKeyEIVP9Pw
 4ieOT/rV83AXEQEH3g6rzvnLH+4I6g/UBV8oGs3bjz6UEhlV0k08aww6Ems3t/bSqzGGlZSOvVi
 EKPJ8as80rj11c167bbh6aWAyRQg35042vIPAlPJU5qP2HJlKLPQqGz1t1ok8wVQUv/J62zgBt9
 froFVirk0L+R4avSvn9WV6bceAR0V3Elv0YKrhwPE4t8JawOyEF2k3ibf/T59Pk9iMCevQcvOmn
 QcaQ9cgR+IQtfkFXttsPEWx4M95vH9vkjAqGXM0fXNfFbFh59WDjODdCleV+u1KJ0ZFUEyte52k
 1+XDXpV9V/LSojD9CYxdozf8/OoH78bGZ2Hsl3B/eKIvLsUbr0THXWSyK8EG7TQJaevfmOJiAHt
 Kgdp/30ltDmfM3tX3WEBVgcfce5KRaP3pG4w+FgVGwV7ODrj1xPQHM0Lj6T+R672h3M5pyAffRE
 7H8jIqEc1IvIP4qJw28z8qWQPC07CqC4wUZEz
X-Received: by 2002:a05:600c:6304:b0:4a1:fbf8:55c9 with SMTP id
 5b1f17b1804b1-4a1fdd48131mr106626135e9.33.1792677805552; 
 Thu, 22 Oct 2026 07:03:25 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-f269-609e-a542-3b36.rev.sfr.net.
 [2a02:8434:7c41:c701:f269:609e:a542:3b36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b66f6bsm102604335e9.15.2026.10.22.07.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:03:25 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v3 0/3] Add MediaTek MT8365 power domain support
Date: Thu, 22 Oct 2026 16:03:43 +0200
Message-Id: <20261022-mt8365-add-power-domain-v3-0-90b82ec1e7fa@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQy07DMBBFfyXyGiOPnfiRVf8DsfBjQg0kKXYaq
 Kr8O05SIQHq8kp3zpyZK8mYImbSVleScI45jkMJ4qEi/miHF6QxlEw445IZxmk/aSEbakOgp/E
 TEw1jb+NAvQVTl4qxWpEyfUrYxa+N/PS853x2r+inFXdrJPw4l5XTXiPOZqR+7Ps4tRUaCMw1A
 rlUGhnKWhihGNpgXMe9gprVTkGzonrM2W6ubXUzrYvp22/Fog7a0Bkoo9aZoH1gHQN7cPbyHl3
 Cx7KbrLLHmKcxXbavzLC57ViQdx+wYZ2SOihw2jT+P3bmPyhgUN9H8YIKnRcoy7ldaP6glmX5B
 rQAxp25AQAA
X-Change-ID: 20260902-mt8365-add-power-domain-ca1946099a87
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds the power domain (scpsys) driver for the MediaTek
MT8365 SoC.

The scpsys core so far only drove bus protection through the infracfg
register block. MT8365 also gates some domains through the SMI common
space and acknowledges its way-enable protections via the read-only
infracfg "nao" mirror, so the first patch extends the core to select a
per-step register block before the MT8365 driver is added on top.

The domain tables and bus protection sequences mirror the Linux
mt8365-pm-domains.h data.

This series depends on [1] for various kconfig cleanup

[1]: https://lore.kernel.org/all/20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com/#r

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v3:
- Fix undefined symbol: s/MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1/MT8365_INFRA_TOPAXI_PROTECTEN_MM_M1
- Correctly check return value of ofnode_get_addr()
- Link to v2: https://patch.msgid.link/20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com

Changes in v2:
- Add MTK_SCPD_STRICT_BUS_PROTECTION domain cap: some domains need subsys clocks enabled after bus protection release, not before.
- Fix SMI common mapping: no syscon fallback compatible, so map registers directly via ofnode_get_addr() instead of regmap_init_mem().
- Add probe-time validation: fail with clear error if a domain's bp_cfg references BUS_PROT_BLOCK_INFRA_NAO/BUS_PROT_BLOCK_SMI but the regmap wasn't resolved, instead of leaving a NULL to be dereferenced later.
- Fix commit message: correct Fixes: tag now points to actual upstream commit (ecaf11aaee98, "pmdomain: mediatek: Add support for
  WAY_EN operations").
- MT8365: fix mis-named/mis-valued PROTECTEN bits (MDMCU_M1→MM_M1, INFRA2MFG value corrected to BIT(25), add missing MFG_M1).
- Link to v1: https://patch.msgid.link/20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com

To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Irving-ch Lin <irving-ch.lin@mediatek.com>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Carlo Caione <ccaione@baylibre.com>

---
Julien Stephan (3):
      power: domain: mediatek: support SMI and infra-nao bus protection
      power: domain: mtk: add MT8365 power domain
      configs: mt8365: enable the power domain driver

 configs/mt8365_evk_defconfig               |   1 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/mt8188-power-domain.c | 164 ++++++++++----------
 drivers/power/domain/mt8189-power-domain.c |  74 ++++-----
 drivers/power/domain/mt8365-power-domain.c | 236 +++++++++++++++++++++++++++++
 drivers/power/domain/mt8366-power-domain.c |  40 ++---
 drivers/power/domain/mtk-power-domain.c    | 166 ++++++++++++++++----
 drivers/power/domain/mtk-power-domain.h    |  66 ++++++--
 8 files changed, 564 insertions(+), 184 deletions(-)
---
base-commit: e91d0b53e2678e0e6439370ead9bf2c71404b715
change-id: 20260902-mt8365-add-power-domain-ca1946099a87
prerequisite-message-id: 20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com
prerequisite-patch-id: 349b47fdcaa519c4bb9430a7d0a9cf34db04b64f
prerequisite-patch-id: 82685c1627b230ebcd75603c5b199ca61b53e53d
prerequisite-patch-id: 102fc1198a2b104b6fe2052d7258a97ab1f6033c
prerequisite-patch-id: 410192d9062fd4a4fe9152a0656cd00fa960d377
prerequisite-patch-id: 65651c5a260e0b28b3561d504b494f6625932a2f
prerequisite-patch-id: f710336972a49695622783e0724531fb2a2eb07f

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

