Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AC5C88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 21:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F41E560640;
	Mon, 14 Sep 2026 21:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O03USw67AzFF; Mon, 14 Sep 2026 21:33:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F218760724
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789421616;
	b=XgBpyIIaxLdT03yJShZeXhqtK5HOiSP717mbLbsV2yoMlHkTcKR1DI82N+lOfSmJor6z
	 x0bBe/XzLkm3BCb//9ElI4O4XtbRHqspv3/DrVX0Go1EneXyQ8uSDfcbJVhMJEDYcpWSr
	 8aun0FBwe4ITPow6V2tPgBrvPASSn4VCjPoCtpIxxAcZbQb542Ffqna4VEW0j49L4DcbZ
	 wkNBuJS+SulmhL07agwmHWkCrdpgFlIxqMp91DarZyVmVYV6L02+LO2cEvWD0wxdoJr9E
	 DMPdItYqUSwwyttdo3MLC2BSg2GTj3sXzoH5af2GfLhVfr3rFMJCCr5++Te5SLTz+/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789421616;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DIyjnHpzStX4nHo2DVJju/0JwGq/qXA+giLI5Kwn3y4=;
	b=IWIeLYru88dg2vDCzubRYUVp8UdX8/doLyhgsn7fOLikG5IFQ64cCojhLwjLyKsc5Cls
	 DJzb5V150uROZoY/xqoWyvmc8Mcmq1aPvt+xtKSfihBm/rxpfi3b3iuut+bX78NICaG28
	 9Ot92oWOu26yIJXAo/NVTk38m+Y4znZa9ylvQ2ZgVwazL9T2XMscH33zajDGUyUaIw4dt
	 FtrlzfgjFPDB2SnLn6kes7Wsoe7Gizv9uLpDTbaWOSyA7Z4chxz1BKV+SvtftI8UYrcuY
	 9yC8dfrXhJdJzk2wXmSSupu4Atk3Xx6hnqZvjV5rEisO6Vfj/qL1VJkBAVaqRGUxYzw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O6eMUNcB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789421616;
	bh=DIyjnHpzStX4nHo2DVJju/0JwGq/qXA+giLI5Kwn3y4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ObVZbMbCPNXf5Xhzs9flQiTD2NgTvSSn8xZGx5k1RxQBxUUbg6aHWqytGtlUORkI0
	 dwtawQDlrAQdHMItfA7xJ5at6G/nEeBUOyoIfxaucHHT/PAt2DY4oXHlXS8pT54tXT
	 IY09WellZIJK8k3eIymtbfWhBKWvGDNmXcCd2ayadjQnh6c8RAOjw+7wBalPn185qW
	 vG3iLGzGisAmWIf/KeUMtEYsIvE/ddXcAYpRFzDIH8LngbpY7FOkFaQA/7he5qYjRx
	 LrwRS48A6XJoVbMQAdhVQvCRiW5ubfRskuvWKft0oe9mCCG8SavXOQYcQcdcOTZJKp
	 fhYXIEOOsFMuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F218760724;
	Mon, 14 Sep 2026 21:33:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76FDB493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D0FD6061E
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:00:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2_TqXCRWxB56 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 21:00:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 66ECA6060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789419653;
 b=U7OlTIe/WN21PNk7MS9a3qUMJQuDnOFb4WmVuFTb5UnD5zjraFzY+zrkFmNOdrrO6gNE
 /jMXq5/HXyBCvy7zhSTE15vqK+x5/Ne20mcbFor+KIikDRAnGaUdHGf2AMzyE94alo2Zr
 j7vuTVOnjS638wenSL0QHOJXjXbKP+RQHkoqG4Ptd+6kCtJSxwDKwT5FWFca2pUjoPlfo
 2kC7sWOA8BJ+HEn70AucxVSEq4LmRsCGVCQMg07VF1GtOei3ZoYQBbqmEKWQccSiw0gde
 u3pCSi1hUJSaE4ZoTJcaRkYObgmEl3i0eiRiPwsca4aLDwk8Xm0oLzGGz7zveDTY9ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789419653;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=DIyjnHpzStX4nHo2DVJju/0JwGq/qXA+giLI5Kwn3y4=;
 b=cpDMMopTNao9U4B4W4c+6U+rhDt3tx3T8uT403ZAJI+TZL3xVAkSQJ2AUDmA3qsGtIka
 0YxH62zhyhwaHJueyLim31cM3LnsYZwpvWeHu0fXGWao6XMUuNngO3XdNiROQD5uOxP3n
 BS3xNFCXMFNpgvxA40HTbbTHaw+xri5wwieEaIimZf+LRXBH8QPP4OjEvA+dcbfHoOStg
 GMBe/JyGPGrBteNnv+4ssi7JfnJ/M5V1lsrodohT64IaR/nQGR8uUj1bTkclBwwAixVFG
 OJ04YGiuGSlSpLvZKyXIk/Y9IfMS2bzYtmPWvZqloIFqWkDmG3tC9ca1bot9T9f0kLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=O6eMUNcB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=O6eMUNcB
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66ECA6060D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:00:53 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8692be1cda4so3158606b3a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789419652; x=1790024452;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DIyjnHpzStX4nHo2DVJju/0JwGq/qXA+giLI5Kwn3y4=;
 b=O6eMUNcBQW4sABln8pz6tJDXYP2dOaLT6PqfnIVXau19V7u8RbraZIAsDJQPDU1RF/
 HUv/RocGZ4Hm3Rm0RP9+hr+BPD6HSDkPiBnwxZSzt2lkm4B4LEivb4fcPVtm+OCJ0ldQ
 WBep7W43ZGsZg3x+cEkcguwNiDEttlL340y/ZfydCCkXNs9XD7pyxii7RloUTooz2ibT
 cywgYMMOfR9FWi/rJCC1XBVA78v9BE3kCNGk6GZTmDcTSlB+CVTBAvqMqT4m8F+Om8wz
 K5LZRkPJU3sCknZCeOFrTx5yQg/3kdcarH4x3XAoEd3ojjP8R+BgfZ4KUbJkxB4rFu3G
 YtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789419652; x=1790024452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DIyjnHpzStX4nHo2DVJju/0JwGq/qXA+giLI5Kwn3y4=;
 b=Vb2u+rb2/LLbSzA7x9F8OI2y2XEJ5MMmNoQCQum1EZP1ajxRiSPCqujf7ypPdT9mxY
 OjyR002FlyaCgTNLFs67+cUvRSbBQMqQ1p4m0iSnnyYDLS5TRNgrYUMeJvLIiACnRfzx
 daikHWZpaiqzswnGiVqMwe8PcK2F/m7dk64F+KN8naACFTP2i0nJVXSrpKma1dPRnQB1
 trOfWi9+M1W0GSymOoX9bGo2eS7OoYo1R+1KfSpkJ+6Ab8pH4LkdXCmFi7d7WzebnCdB
 TmrwIBPQL8Gz4AHbNHeBJiRMcaLMnPq0vrLPnZgqDdrFRfPRWWrkyk0k6ee/CY2anzLG
 sdLA==
X-Gm-Message-State: AFuF++kJUvwrxBL0SNfpp7LEmDFuzNEMZ71ePnN6s9G9nWkyTMgkTrpp
 hwZxqCd0B6IWWFDUXuJUYSiEzh1K3jMWSqcfvngUtnxOPExK30YRp9fQ
X-Gm-Gg: AYBFou24QfdWaeQKlSxJebM4NGGuPwf32JKxvAnmchfFi+2Dq4GzAJlSGalyZlsvZSW
 SBHXsi+l3Xx51anG8LyXJWmoIrMv8BwTPR/H5kI8k4KspAwBxNy1dBvvr8YdKRo3kmzJ/vZjdUk
 ZVHTOdJBUED86TZnw0e+lap7/zOR5LtDa55LtptbvWbZnnhylujvBdW0hoI90JF/O0q6JurBfvU
 axSN3VWJta90uCi0ZaQ4qGvPVeyuT9TFDBtCa62Mr2MABe/anRyZtai47FSD3hSsbJCdd9/Ymw7
 b7A4nZQYTaDHNYG7pw+/aZJO4VueiVhOuaENYWUMzluSPc9pUrTvfDgDohydgY1fJa0keQ8uDY5
 i6cqBkSgHVpeP1RYo7zMVmvoTxYwhjBqNI+6kPmBmP/b6Am98nYYHKQeZP0gHfOnKBX4CpI8jxE
 DGO4bQfoEJhBOX3U+sL3vSDhahFQR70fzpHrqo+xQC53+AjmgAcnCLJZLzQjQmdUZWHVzFVP5je
 FqMyEzeBgCy8ZN6Rn2VEIiY9+uxQbdSm7lXFyvJW5sP2dyF10ZOBwyRVd+ToG43nfoMyLj5NUAL
 SwbeI9kpYVxA8OD18KnifxD0lPObhfgVop3eWZaRpwMI
X-Received: by 2002:a05:6a00:12e6:b0:857:7317:cff4 with SMTP id
 d2e1a72fcca58-86f85ce2cf7mr7750861b3a.21.1789419649507; 
 Mon, 14 Sep 2026 14:00:49 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b5674bc2dsm5263328b3a.59.2026.09.14.14.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:00:48 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, daniel@makrotopia.org,
 jbx6244@gmail.com, ludwig.nussel@siemens.com, anton@binarly.io,
 jonas@kwiboo.se, Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH v2 0/2] Close the FIT signature fail-open on the image gate
Date: Tue, 15 Sep 2026 08:58:38 +1200
Message-ID: <20260914205840.360734-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 21:33:29 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

fit_image_verify_required_sigs() returns success when the control
devicetree has no /signature node, so a FIT with absent or invalid
signatures verifies. The only indication is a compiled-out debug().
Reported on 2026-09-08 [1].

Patch 1 adds CONFIG_FIT_REQUIRE_CONFIG_SIGS handling to the image gate,
patch 2 adds test/py coverage for the missing-node case.

The configuration gate has the same early return and is already covered
by Ludwig Nussel's series [2], now at v8, which only touches
fit_config_verify_required_keys(). This is complementary and reuses
Ludwig's Kconfig symbol.

Default n, and the message is conditional on it: enabling enforcement
breaks 13 of 32 test_vboot cases that assert the old contract, and
Rockchip has no /signature node by design [3]. Tested on sandbox only.

[1] https://lore.kernel.org/u-boot/CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com/
[2] https://lore.kernel.org/u-boot/20260618144742.v7.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid/
[3] https://lore.kernel.org/u-boot/44dbc75b-13e6-4242-a1a9-43264f379391@kwiboo.se/

Changes in v2:
- Shortened the cover letter; details moved into the patches.

Eva Crystal (2):
  image-fit-sig: also require signatures on the image gate
  test: vboot: add coverage for a control FDT with no /signature node

 boot/Kconfig                | 27 +++++++++++
 boot/image-fit-sig.c        | 15 ++++++
 test/py/tests/test_vboot.py | 96 +++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)

-- 
2.53.0

