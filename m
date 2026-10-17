Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26625CCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 16:18:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C1978122C;
	Sat, 17 Oct 2026 16:18:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gO3RBxo6cfJ; Sat, 17 Oct 2026 16:18:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18FC280FA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792253892;
	b=o38kFaz5UxcCoTGOTybiVfCoxNoFHFMCyqIbWkbyK5oi4xBP1VLJnq/8GpNWEjH4l+3+
	 RylxLzSQUN4G/OkJ6E10g60FXK37NmMRYZDwWHQDb/XIW2yec1H1Rcu3go+14ci4+DURC
	 kurb8R6AmEwQLry5YEeNHRcg7gfVjpx/prUcqEOXGS1SFAZKiG7KUQVt5bTlNTZ/aXxpD
	 flcXOLkqdypa6sXt8XXW2Vf/FTLNV80gh0U7NdKxSTI8VXA5w5XoDOnSySflMpO7n4yFy
	 iXY6/KJ/lTZzBYOjMjrWucvCXTXGSQRYaGOp7ODEulIpr7iVIiT4fPRreZ5rVmi1yKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792253892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=emrGKWO2H2A94a6oY08dGO2KoCTNzrLfurlzicQsGmk=;
	b=sPyVhQGMvp2/r/cxkTGDm/5AcqhbMnS1xMPdHQ1v4H9Gbutf7/lTMsY1HzHwj+UiBr7T
	 q+7UPJEED6X4LIrrsiHusUasYBJ9mbEyJc5wEXMrAxjbHxdPhaVGyt3SoVPiFrnmI26e5
	 fS24pWfY+3/eulQckGCz9wz7TFUaRgFrxbNLp2s35JWRMEWjysOyLlnwx8UJa1VaikoEV
	 psfccWvrPXPzAFyoTXOoyBo1/ka+dFuzIwAZFJ9HIkpEI8hbMEO1O9cyAufYVPQXK54RZ
	 bqdqLlcxbQV2esKgmyrRHPwfxqDHKvP37bcf7sPOrz6Feuwmtz6I04iccHorDna3rvw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LueMM2XA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792253892;
	bh=emrGKWO2H2A94a6oY08dGO2KoCTNzrLfurlzicQsGmk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KYIOnDDKmZcHcBN/HDfW8/n9IimtWXcDFPFVm/KFbD/d5STjF8i+m91IDe/6Pkilg
	 5bC/5tmoGCuDvqVvlVUKz2lpimYh3l8kHY3EbD6uERK+oixGRJdhSIY25GjDjxi3kx
	 z1eCjOMWzC/DY0ZRD7XFOJsmVcEkm4nRLiQm8SSoM6vMVXsadhZDZR3sQ42ovENJuA
	 NNsCiNO8EvIgtWTAiFdbRY8j7EG6c5ldDok3XyONLOpiQsiMUnPKoRQ5QIIP+42jIi
	 OWznchWBJUWCur6LWDR/HKFzL0KttmUg+QURtQoX3dNx08QTcmDJiG4lRUQjk401Sj
	 EfSVzSQiR3Myw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18FC280FA2;
	Sat, 17 Oct 2026 16:18:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AA4F2A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 16:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7830E80FA2
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 16:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qatpkGBaQq83 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 16:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7915880F92
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792253889;
 b=XpWmdmPDFYUlinHe/kuRde9uAyVA7tt9WchN0f71x9IhDvNVUlm3P3pMY4/UOEYvAtoF
 4QUmzPFMasrzmz0Jm+pT24RhefYsrX9DvzBf31Z6uk6nJ1+o5eeeYvgEx9IbL0Yf3jYeh
 JQBvxi40SVNVM2nuCHjOQS02E8KHh8Y6bB59ZRLqKct+4qnIm5f592Q4x4ARLLm0TxKAn
 MOohIktf1Jc6twm2gw6f2oGM2Bb8lzGSfKoVlsTjscETbkevG2YEdgpVxL7xxnB4TQwD8
 4lEYADc7o3MezW7QRlvLny/Oco7R547ygI1GDcNJzgVxw7TkGwfSwJkJJSl1HZdJNJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792253889;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=emrGKWO2H2A94a6oY08dGO2KoCTNzrLfurlzicQsGmk=;
 b=acwez5rV0CoOL42Lzvgug/DRF3NUuUP23rqghiQIApUCVEUMSvILTxe1lnNccUKVuty9
 OHvutnjxQkJnPG3b8bVp5eDlVFLZjvFCkqB44A6YyACrEeJrcHGiANpV8coTrLEXGvxn2
 49dqPUXhbVeqX0U63Wa3DapP+C+BqyHq0j44zZVmOX9iVpRrCcLLG2TOlTCX5b6A4//Th
 TH5xmPzlBs8wtLQrz4ETN39A/W2UNWTjuADGoPWou8m+D1oUkEQ4G5yxlEoPTtnh2kChH
 aClrbQKrbfNjSiA8PCJONIVMgS2xicAu3p7+m57ArZJI//O+QiwxxapAdbZJN+iV6kA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LueMM2XA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2d; helo=mail-vs1-xe2d.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=LueMM2XA
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7915880F92
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 16:18:08 +0000 (UTC)
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-7cb6dc850c7so165362137.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792253887; x=1792858687;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=emrGKWO2H2A94a6oY08dGO2KoCTNzrLfurlzicQsGmk=;
 b=LueMM2XAIOA1FtEbvvYdfKCJEcmCWEfQfUizWzw8ZgEd58g9NGx7zupRyOJksIdChX
 /WesVUG701pGHd6BJ1bjfjJ0Ztapo+T1InGqhH0dKP4/79/DXYA/lzzhGo7QBU1+iI2k
 Dh0E+5AZ3YM/t2UOcKttmLMnzOzOnOKLdzTWuwk3mjIAH3BoDTxayVrSLuN0ixUHDI/P
 6eDqG6xuwRSgjsEVCg44ns0pvoX/BGsukzOlXPwS+8hwwVuyIHN8DEqikI58jWLqQEua
 nbp4zBNDElRXUMfnrRHcBD2kf+oIMcA7DlUPWKyq3JAFMDoCt2BUyhywGvwLx4DiwbwR
 2s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792253887; x=1792858687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=emrGKWO2H2A94a6oY08dGO2KoCTNzrLfurlzicQsGmk=;
 b=J8dPkO8fHZkSSENzRvahNH6Ym/iYKwNo2n+YjjYgh7oD1pbUDsn69EpSq0rsaPQjp+
 dyluglG2T/6gYjuvaAhoImWWxhvGt07Ubchdt2YExtmohI/6dh9uZcbbOKskOXi8+kmv
 0hLYanX6MWFinpLZQqCzxowg4Pel/V80t8K0EtsulcQUpCNSbFUsW58UQpSG69JQL9Z5
 nf+kW/itu60PIOa4A0LRH8G1h59mn0+QzLOHYlkriJTeDWCDcZMT+rI8/uMtZVsJRoVB
 LOcWwBqrxCm8uhKizMjfEORpDAP+JialEkwd7pVtRf2bvnym3fY8AquH9WMincNE7tsa
 9wWw==
X-Gm-Message-State: AFq9FYKWLqrPgBY4yfhPEZPEkGSYDRnM2yA9GiF15t48KhytEfbDs8Jd
 7awnW3PgGq6WkGansxD93quXh/y7apQIxpTv3u2cvRkCAk5X+U/ukWrO
X-Gm-Gg: AYBFou04tZ4L76J4HJIZFid/L8S9PZ6FOtJNlk+HS178c/ubq0sSthJuXZSCpQvDesP
 B64eOJrILXIN2R/HNITs07jBV3lgrkDwQi0pwGm8PXwv4CeRvk4K2JoiRGVJTKfMvLYOzFQwwNn
 OfZJQfR5TttCJ2Xuu8HYG+Nf0skpP686nqtv5g1Eq9BdBZC50EXK6TP57tF7c6MILhYc9Nhesn2
 ZBu8UI8nFve+8OGcmH89tRtTfvaqYG0YRjeQo9k8sbLsTYDO+c1XqQvOb69MYUxr6X5DkmXH6EC
 wcFp8sFWX8z5R3szZqKukyXIZJl8GtS2i8V3xXKPMRQ/0HRWpm6bZY1Oaqv0NmWUd41co2bjY1q
 PyVqDTLWIeCKBzdXXF/BJxKjAix8b8g/8N17eF3Qxolb/5PtmzPW068ZltjMS01EOuRxcAl/R9C
 MMg+xBvpEtVWHExTozdzyJ47J5UQKR00H1Un5UqdUCH3vznLPjYCiNdztG1gPjv+OiRealRIP8q
 gMlCVWeGsRr7jUflA5ifQSORKdDQDD0Ckq5ETIlyFGwTrNn2WjYDkej
X-Received: by 2002:a05:6102:955:b0:7cc:2946:7f69 with SMTP id
 ada2fe7eead31-7cc368fe22bmr747915137.8.1792253887337; 
 Sat, 17 Oct 2026 09:18:07 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a801:42fc:e5a:e466:ca42:1512])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990833c1917sm4167816241.1.2026.10.17.09.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 09:18:06 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, alexander.stein@ew.tq-group.com,
 aristo.chen@canonical.com, mehmet.fide@screeningeagle.com, ye.li@nxp.com
Subject: [GIT PULL] Please pull u-boot-imx-main-20261017
Date: Sat, 17 Oct 2026 13:18:01 -0300
Message-ID: <20261017161801.9045-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Please pull from u-boot-imx/main, thanks.

The following changes since commit 65a7532545336e4b73e049a69436e255da7df961:

  Merge tag 'mbedtls-2027-01-rc1-101426' of https://git.u-boot-project.org/u-boot/custodians/raymo200915/u-boot-mbedtls (2026-10-14 13:54:12 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20261017

for you to fetch changes up to 8bae10e9fd0122540d23dadb9cfad042fece46a2:

  imx9: scmi: Add missing UART clocks (2026-10-16 10:14:47 -0300)

u-boot-imx-main-20261017
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/1607

- Add missing i.MX9 SCMI UART clocks.
- Drop duplicate prepare_mcore from imx8mm_evk and imx8mn_evk.
- Support the Vybrid NANDBDB boot ROM.
- Enable caches in SPL on Toradex i.MX95 boards.
----------------------------------------------------------------
Alexander Stein (1):
      imx9: scmi: Add missing UART clocks

Aristo Chen (2):
      imx8mm_evk: Drop duplicate prepare_mcore
      imx8mn_evk: Drop duplicate prepare_mcore

Mehmet Fide (2):
      imx: nandbcb: support the Vybrid boot ROM
      doc: board: toradex: colibri_vf: describe the NAND boot control block

Ye Li (2):
      imx9: scmi: Move u-boot early MMU table to top 2MB of first 64MB DDR
      toradex: {aquila, smarc, verdin}-imx95: Enable caches in SPL

 arch/arm/include/asm/mach-imx/imx-nandbcb.h |   3 +
 arch/arm/mach-imx/Kconfig                   |   5 +-
 arch/arm/mach-imx/cmd_nandbcb.c             | 137 +++++++++++++++++++++-------
 arch/arm/mach-imx/imx9/scmi/clock.c         |  15 +++
 arch/arm/mach-imx/imx9/scmi/soc.c           |   5 +-
 board/nxp/imx8mm_evk/imx8mm_evk.env         |   1 -
 board/nxp/imx8mn_evk/imx8mn_evk.env         |   1 -
 board/toradex/aquila-imx95/spl.c            |   4 +-
 board/toradex/smarc-imx95/spl.c             |   4 +-
 board/toradex/verdin-imx95/spl.c            |   4 +-
 doc/board/toradex/colibri_vf.rst            |  25 +++++
 include/configs/aquila-imx95.h              |   2 +-
 include/configs/toradex-smarc-imx95.h       |   3 +
 include/configs/verdin-imx95.h              |   3 +
 14 files changed, 167 insertions(+), 45 deletions(-)
