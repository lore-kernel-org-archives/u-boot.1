Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A14606A6BA
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MKaMcg+8;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mM0nNC9w
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A269D80D2B;
	Fri, 20 Nov 2026 21:50:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msBNa1MLyfn0; Fri, 20 Nov 2026 21:50:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 97C4F81675
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795211444;
	b=VjkUW2hVPKFoXsQq2i52y+eYRhNBz17NrHjU63gaY00MnXv9p2HYa3WelTB3yPy/T7Ys
	 zP+h7W8Trm4d7yResFR6/6olblDHSHt2Ca/Slnrrmga12PyfzNKOqWU75VX/iC4Vr2hR5
	 mONmBfHK1wLqD4uPZodXZ0OM/8n1O6CrUcnJKsduTTBiefGict5ZIdp+iVgEaA+7JpDL/
	 JxXfsdDb0X9tqSkN8IXlwG0DCMpOW79EXp2Rejng0u6wBoA8yX+oGm+bNzziAG2n+7efF
	 FNSF2a6TafDiiZssN5lIyldKf7tj36Q8GOng2NiapeJ+5J+QpkXXy8DHlcsDysa6Jeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795211444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Yh/qhkP8Nh3Y94gDOn5mTbGM7xnNQX4vpwUGOCtwUUc=;
	b=cnX30S2zuBI9jsz7ZU33pl4tcONsc/IgjCqo0kgMr4i3mjhUQl1NOBUJ5CW0RwQ2AJ6V
	 leAJbAgl3NUPrHERCNb+GiZ4DY3s83/Y3ZR7VV4uEL/FvnsmF9o93hamLieayQ2SZ31Az
	 PtUCIDrMqxKY46xIj4J1+IsEethw7a0TmXe/dUcJ4U3WcgDO382Yd72ycJEx+xoKZN4HV
	 H/CvyqUNlW5IPGYAmhWUALkyHrmn7a91jBchzMIrRG/pfMqFxfggXlZv43Qm+PWkC0OxW
	 O5oWWMD6TshjDovvoJpGBv+js7w2uqQqMlEn9kiE2uJfNpWwJWxmC3mnx9rKIzntEbg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795211444;
	bh=Yh/qhkP8Nh3Y94gDOn5mTbGM7xnNQX4vpwUGOCtwUUc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MKaMcg+8cW7dNff9M4ywVLiz9OCvu08u/fabaO7ivEBUdKuAHEBPNYjrK8j4TF71n
	 o0UbXygilDt5O0kkQ+EGTi28xDOtysHyfCIEgDeqmfg7RcmKz3waxzn9nK4zXQ8eeP
	 IAX7mqVW87AyDUssd3iyE1T0RmfaRhZbmKOWghm4MyA+5MKePx+8JtprlXINg4JMRS
	 Qsi0ZFMDDH2JWkKHP+KJBSfpiymobG0ZfhwFiSYi1MnHs9HP71GbjcBn7DlapUL1cT
	 b5/b8XZ/Zy+tJUl+NsfV/ZoiwI9aFTGQ2hqYN8Q72cjkWMhft7rUP8/eryejwx9Bin
	 Flws13XAsmcjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97C4F81675;
	Fri, 20 Nov 2026 21:50:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 082E4465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE96640208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JnxzmF7wxec5 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:50:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2ECD640176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mM0nNC9w
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2ECD640176
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:41 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6df7f544919so844872eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795211440; x=1795816240;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yh/qhkP8Nh3Y94gDOn5mTbGM7xnNQX4vpwUGOCtwUUc=;
 b=mM0nNC9wuxeqeVBw7kFZ3K4/XPeJUuAHORquPXBoQ8iU6IDoLW5hLScfEtxpFGlpqc
 bbG2NFwTnOwp1cQnCYox7tB6e6mpiA9UHRPm++CF/BxZBNLvufRRJ1+oji9sE3zQFu15
 1O7EPG95rHTGkYRVpS5VJC/LZ/V8EohQxdOU7/tA+wvlPwpu5QAFzO59rWtdLEIB7Lc2
 7x8l47h0s8qh2CGuEgsYZ4Bq8rVfozB5HBnvCvFji6cODhcg3T+BFhYSeMLW2f0aFHw/
 kbtNWaUFON3yZwVKq1d2K0SGEXqkHXr66eSkVOv3JZHipyyNbmfhErECabmwtBbAgPPJ
 tcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211440; x=1795816240;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Yh/qhkP8Nh3Y94gDOn5mTbGM7xnNQX4vpwUGOCtwUUc=;
 b=HS+DFhvhVatNBFiqQ/sBpmkEVUQ8yBdT2goZWpOn3yvJqFuNx4n5P2LRw7CXYr8B7b
 K03QPQI+CgZSqNE0cTBAwKeCpY0Lic7NIg5pWiJPDmQjO6AZxP2yBdoxPqZR3am1GIKN
 vSYpdOY2vkOL2rRq+gK9kXSMq4E6BHvVs9dgTfvUFTCiCfvJTuJ0yW/UMb9OuIqH/kaq
 7MUEiDhg9dy6dSWDWdBXsAJ3pQTF680IaaIDrC18KnY1cstxxjKmZ4nW9fpx1jkTDhre
 ZF3NZO8IbQ5vj0Gm400fFAabVCJD/HF9TYl48DboUVSwfxLG9HJeG1ZOmAG6k2BJfmJX
 YrEg==
X-Gm-Message-State: APuU4Z+EmCMP3WLBNv17wnnFiYqaT6ndT9N4tOVJimsCV69d/Q9k68/O
 igUtPZiFQdve6Zt+RI5JQnJJfoK/U18hyBEJWX1VBkl3EKJZT4G1YDwotA31S8R+vVI=
X-Gm-Gg: AYBFou0DDTkc/fXop+sN6tY5FwyzVm0VJMwn+Hp/lqaEKXclS6/oHHHQtwOKS0nLIVq
 P5UFz8cJevxAXZHWXSibe0kyoMWbMFCS8bV67m2v/oNwNDir1C3UCKf9aqoqtS7T9TsJaVLGC6v
 h8dCnffKKWeW+sjCCiufCgCKqphFxDVyQfZoMek3ic6t5h1wK3EBSCEcNeg5xoX9lDtrTPphWoH
 Y+KmFSF2uWVLdZREoRZNDnf5RLvf/66O2edetq+KHukwJRHDaU0J5y/Xz3kt5VXWE9TatR/qb2u
 pbPudoCED6qKOx/oH2jnnL7d/gNOLgJf0B1PWDXIFrBOSP1EAIg2+5L5iFyVL/FugRG7cI6WZ9M
 IUbatGVPcX8yFWp/HE2dh3IpqG9QA+u2Q+4V8T33iGI88IaxKemEmOp1/7y+dt7k2AiJp3dWM6Z
 1/Ng+oYy6eP1zdEf5uWSqcFW+eEYSUDA03s92Kk01qFkun79gmnKqVNIfX0ohiRoM/iRsXnhmFD
 ndqsuv+aL3BOrhj75vzFgNMTRYwTxQsP3dQR1HNljv4GPKCFW/dmba8zBU2rbAZZK0d3FqmQu1k
 jXLWj3P0yg7Fa+WjLg6rq12JOM8WuP/uHWtnr38XDqJ269amoMnsQA==
X-Received: by 2002:a05:6820:808:b0:71b:1653:93cf with SMTP id
 006d021491bc7-71b394d5f46mr4243348eaf.51.1795211440555; 
 Fri, 20 Nov 2026 13:50:40 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd044fc4besm2846726fac.7.2026.11.20.13.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:50:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/8] mediatek: mt8189: add UFS boot for Genio 520 and
 720 SPL
Date: Fri, 20 Nov 2026 15:49:27 -0600
Message-Id: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQy2rDMBBFf8VoXQWNLMkPSsl/lFD0GCdq/Ugk2
 zSE/HslJ4tushm4MHPP3HsjEYPHSNriRgKuPvppTIK/FcSe9HhE6l3ShDOugEFJh/mHHnH0E60
 4o/Hc06WLVGirdFfVDitG0u05YOd/N9/Pw0PHxXyjnbPZcyPgZUnA+bFGBoxRb8C2eH/ymkz4y
 oRVUEYViJI7Zris7X6KcXdZdG+nYdil8UH+P50yvH4ZFGcClFWci3bl+dDoiDRb+bktHDghbcO
 VlhV0RllA5Spg0vKa1WWphGpAoiY528nHeQrXrcIVtigbGph60dYKKUvDrKzq5C1Kszf62nsTM
 Ocgh/v9/gcuUMjnmQEAAA==
X-Change-ID: 20261013-mtk-genio-720-spl-ufs-4ac6af78de70
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4532; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=JfD+WJl6aekp6wEfZs3q1lMFQ6N9ZM2tMOkdt2cv+Sw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMBsuvRxVC993Vi0n7W6zpoX1KKh4D6sv9c8C
 ybfowKv0u6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDAbBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AdZgIAI6ofbbjUBstTofAhByOwhg/1FPPxtvpmznJnrl
 YiPETlCJhTWt+qFAenTLpqHsP5wAWKMMN7+6O9TGRHxgRjStMx6UvCjfOkR4oj3y+3NM+wvFxi7
 Qnsd5nlQvy4FyLfc29BAaOMcF02Db55+PWveBOIDXuuVlF1JSZhKkMBztaxepG8bN0OpykeX5jg
 jy2fHxwierb7QtSZnFE+2jTLagSFa2VIWaiqtlmwDaOLm6y8VsrWuuVGtNUWV+T5pMTptVO1m/E
 YsCIaKBN0j6b08CG9SQqb/Ytx+sEv/G98UFqqD75ctSN6bM0oM0J1f/8SiQPcuTsw0d2xSG6t0o
 PlrA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for booting the Genio 520 and 720 EVKs from UFS when U-Boot
SPL replaces the platform BL2.

mkimage gains the UFS BootROM image header. When running at EL3, as it
does in SPL, the MediaTek UFS driver skips its secure monitor calls and
the SoC code resets the UFS device instead. SPL can then load the
firmware FIT from UFS. A new config fragment,
mt8189-genio-spl-ufs.config, selects the UFS boot and sets the BootROM
image header to UFS. The DDR loader that runs before SPL must also be
built for UFS.

This series depends on:
- "spl: ufs: add UFS boot support for Qualcomm" v4, which adds the
  generic SPL UFS loader:
  https://lore.kernel.org/u-boot/20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com/
  This series was tested with the changes requested in the v4 review
  applied (the unused UFS boot mode dropped). It does not depend on them.
- "mediatek: mt8189: add U-Boot SPL boot for Genio 520 and 720" v2

Tested on the Genio 720 EVK booting from UFS.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- tools: mtk_image: fold UFS into the generic header helpers and
  comment the 0xE00 header size (Carlo)
- ufs: mediatek: reset the device through the SoC code at EL3 instead
  of skipping the reset, and check for EL3 at the call sites instead of
  in the SMC wrapper (Carlo)
- New patch "arm: mediatek: mt8189: reset the UFS device without the
  secure monitor"
- doc: name the SPL UFS partition and device options, apply the BootROM
  size limit to the UFS boot LU too, and drop "out of reset" and the
  reference clock from the DDR loader requirements
- Rebase on the new revisions of the dependencies
- Link to v1: https://patch.msgid.link/20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com

---
David Lechner (7):
      ufs: mediatek: do not call the secure monitor at EL3
      arm: mediatek: mt8189: reset the UFS device without the secure monitor
      arm: dts: mediatek: prepare Genio 520 and 720 UFS for SPL
      arm: mediatek: load the next stage from UFS in SPL
      arm: mediatek: make the BootROM header info configurable
      board: mediatek: add a Genio 520/720 UFS boot config fragment
      doc: board: mediatek: describe booting Genio 520 and 720 from UFS

Fabien Parent (1):
      tools: mtk_image: add UFS support

 arch/arm/dts/mt8371-genio-common-u-boot.dtsi | 17 +++++++-
 arch/arm/include/asm/arch-mediatek/ufs.h     | 23 +++++++++++
 arch/arm/mach-mediatek/Kconfig               |  7 +++-
 arch/arm/mach-mediatek/mt8189/init.c         | 17 ++++++++
 arch/arm/mach-mediatek/spl.c                 |  2 +
 board/mediatek/MAINTAINERS                   |  1 +
 board/mediatek/mt8189-genio-spl-ufs.config   | 10 +++++
 doc/README.mediatek                          |  1 +
 doc/board/mediatek/mt8189-genio-evk.rst      | 49 ++++++++++++++++++-----
 drivers/ufs/ufs-mediatek.c                   | 53 ++++++++++++++++++++----
 tools/mtk_image.c                            | 60 ++++++++++++++++++----------
 tools/mtk_image.h                            | 20 +++++++++-
 12 files changed, 218 insertions(+), 42 deletions(-)
---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261013-mtk-genio-720-spl-ufs-4ac6af78de70
prerequisite-message-id: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
prerequisite-patch-id: 8adf07351c5a4eb61976ceeced2d0ab0eadf235d
prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
prerequisite-change-id: 20261013-mtk-genio-720-spl-1620416c6224:v2
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175

Best regards,
--  
David Lechner <dlechner@baylibre.com>

