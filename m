Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C675CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD28681310;
	Fri,  2 Oct 2026 14:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_SJVF5-mnxH; Fri,  2 Oct 2026 14:01:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5333E812F9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949675;
	b=p/QtHCoGDNLn0o6fLhjqA1TP4uyk6+uqWgoVgvcumV8ldsd3GJXCqnAb4zYY2nq9A9TF
	 k3zxr2dY2DXwZPhOtsBx/Y/itZf7/sBBpfdSsUmfAzGZD9Ft7gJ4/1Bw1D4Clzstvk3+E
	 aelLSxz2F+AJKsPR3DxPejTcpk2kvONV08dlLBaPmRQeo26I182yQccEHL8c8R2Yi9FmJ
	 HmCUP2yD/Xk9dhQ0V+clgFcslBdiupxpwRvaQq+74MupBwnV+bJPDvQuwyfFgioEc3CQv
	 J25N67SvKJVidhmSIYIuZud+97pStBq9leKfAH/YuYdKjWk6ePDV32TXaMnx7tvnd3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BhuXXB2Pax9JGXQRZvPVetH0cU7tqjb8PnAyCxn97ww=;
	b=ewn5oB97I7jULTLmtlf2UO4s1tmoAp78nSvAGTRGQaTDVOkZq/oZ1Tl7ELnCVrwEhaZp
	 i7N9g3PoYU2O/w5y0oJdCt91JlxgNDnnODRJQw7tLKLWHFEWMUh6gvQALeSR85EPpJdoF
	 1yfY5g37/nsQo+dmzqWivHdZErh43aGJ6HXpGydJ2HYtFsBOu1zgUIlLXkffvsrpGKOeg
	 T/mqDJOciFqSJgEE6kZC7+fxYMta2enb6r55sXmy5dZod5TsCTFASmv85n6CMxBSoFzUu
	 LaGef9FBsWF+Ayq5cnM6BTIvY5KT1IY4a1jvV80eu9V7JWmYfE2OgNIF4OkP89lkXpA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949675;
	bh=BhuXXB2Pax9JGXQRZvPVetH0cU7tqjb8PnAyCxn97ww=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lMwrxS9TUR7khif7o+Genxav3oPliamOOB7lIKrWubaJtn5DSL5dwz1MQr0K8YHuy
	 O5j1AuUP65ImyjpXs9gptL8WekXz5s/UrPHFu8fz7ECKFWIcoiPdnC+Sgpybcw+6PR
	 ImBGnv0a9pyfcc5iqPYc708tLGGPQUs5idsgFXfJi1AZ67cSA5w9KB0V79h6D4ljb/
	 XtMKmRmA0yQr4tHlJnmjC6+u2m0V9DrvV+ZBFg7nEu+Ie9mkaNq5Knh3UhFdguyQ3T
	 Ed+y9LZm16X13x9cDjnNcw4q+lf2eyx/Cbp/mB13tLiFsbgPDryI0fRYHfvgyfF5Ne
	 NK+730E6bFhzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5333E812F9;
	Fri,  2 Oct 2026 14:01:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D37DD435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9EAB60894
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NB6FlUqXivJ0 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C58B4606AF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949672;
 b=kz2P6coci9ZVbB04XgOR9pHKd0ofXtGYCYIEofBPTYbwIQUTvuSGUWYt8pLTCnUuNWNG
 QK/guompP0C3v7jtCzr6MwhIv5uw6+8EVP3S0Uz4+iH65iB8+wyX+DsaR1NV8aovM0zgP
 67/NCHsjFYkSHRrdskMS5ERx5xsb/vbsd3RAGP1MFgqTlz7xT/l9i/d5MewyAyGhaCLsc
 /1MnsITzB6nilkifjUBdIn/i17zY8Czfhli3J4dv6v9nK+UKluUoU/l2tv7GhK5m+L1Gj
 J27D0GXL2bFTS80WyxZ8nqxrWEkoQAP9LnzODnK0etgkS/IqlTDcTRSO0d9Ln+qxT4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949672;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=BhuXXB2Pax9JGXQRZvPVetH0cU7tqjb8PnAyCxn97ww=;
 b=Dt9wFevuNJMPR2kitlKMvrhXbbdBA4PVIV9Wdf5hAZixvHnkB155xovaY3x9m9R0KtoZ
 Mwu6CYWy702ypmcz8HtGlS4xPLPXE/fcsQ8AST34mekHrPrSzJjfm08lFaJId8fhMzdf/
 tBqvt2eCDqJvShChxe+EFjGdSXlDMO7xXyU/c6i/ZH6LhMEPZTRt7hg/c54cLPwAisNiO
 gi7rMTA2LwmidXtBiQTbNciIMIvCQfULCH1H6URQOvDiJ3UKGtii7KbxZtaBXMnRyDQS/
 XEilF+XlQI96by6umJRnLTLQN1A9/8tU9Q90IiAukqbonPAdqBlSsIZ3ky4HoA7l3EQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=D1UJeQ46; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=D1UJeQ46
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C58B4606AF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:10 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48aff58e6abso1760620f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949668; x=1791554468;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BhuXXB2Pax9JGXQRZvPVetH0cU7tqjb8PnAyCxn97ww=;
 b=D1UJeQ46NC94WkJ8I1ctP+B39ZLzsVRltJ9CvCBBcVg5GuQGuS1Dy7rMTzJqI/AMO/
 l1Y4PJ+/aOScu68l39gdFNif0h3KlYRm7Ky+cU71FAqQEOctEZ0dihVgBWuwtu3fxPAC
 w/xgnNAUJabobThSoKnKJAV8mlALJsRXG4VeCcYj1gJ3ezaNHOfgC0SYu9wQ9lW+KFbr
 P79MJdvMX2H90JYIhtyQ8ueMhm61OkC11NT0F/Me30wRi8DUyHh7cSkeahq3TaWO9cfk
 le4Zgz3/cbKh8BK42s5EX3FQqKhgJuwNtGxDHv4FB0SLxtra5H5gsYohHUngBQg3Zrs8
 1Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949668; x=1791554468;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BhuXXB2Pax9JGXQRZvPVetH0cU7tqjb8PnAyCxn97ww=;
 b=FHdvq1qZWHOB6mbgmP3Ojj7T/yMcjIqdiQf7W6Ugzwv1BenvGXYeelbUrAv1nIgWfZ
 zeYFvXaSmvj30EYiynVUH2askK32njuf46R+fOqufOS6GmSaMA3UNJJB9CJ4QRoveGxw
 mdTQJe4hBKIx1Urpf4DXUNpcq/W7BG5Axw7BYBzZaYq+Yri+ocnTv3woP/LsAbHC4zw9
 JAsuxxCmnn5uu26t0fV5mChlx682t8z5a+vTiT1GMTzO8G9hTnSbQT0Sljm8DKYSqIC3
 feqJPI/hhzJVMJZl6Qu/V7ZlEGS4q8cjes4F4AS8JVzMaPCCC1Bu11w+9OxhXGsYzQfR
 EU0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXx2NIFeVqq3BXsblBeMZBFzsDzp381BaTI24xRMdH54y/H2A2ophl+n4w3smL3Th1HXk/62Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLyiZMTqq4kq/TYtk9jNqcehLAVha4rfBjLJuz08jmTPQZrhzla
 r3CfAAynoZaHEgkL6YZVD4sRQuMj+fjQ4UGT+nDF4gjpARJwxp/e/v+gb6NF1q3LdVA=
X-Gm-Gg: AYBFou3PP2Dhrfa3c3Q3gTc8IbGi2CscMnrThWSVNvKS6TinbfknE+oF+9SxTFlxG1P
 jP1lYv+IqeYqY/dZwJb37txSpt1/KskwnmMJKW9MZHwj+c3BFgAuKinLhLITAhO43I9KAHhYDEF
 3X3s4gvI2p36g1G0VvBMtqs3zt5U1fbsZ6N+3Rg9uJvFjBayKzGkkTiJXfImOXkseBQbowYvVrv
 agFK7j7DX57BBvcVHttTsjKwG2E2Dgh13o1HHonSCtk3t4JkqacBIZ+g32fI4wRMfVPFBMdlRyv
 oKgQ3j875S+HALlLVd0BOni/3TX1BSbxrZz6AkrR5zdOnzh1SUoZQSFveeBMqS/lCQMqUnmO6sZ
 iZBfb7gyqCTAu+e+lADbEv2LxFz7hi2LGEgG/zw5AsJvjcgrA6UGxHNdPUT7Iw/u1VVYI/8F+S+
 q9JVFtDKiIzgF7LfaucKrxKKDQhi7iKiOwqDbu2oAdD+/o3ZTLAul63DH6jrGKyMsZQ34ronQ8m
 o0fLvwmSSZYVjFPHOduhmZdiGvdGoGbtWiPDngGkw6JE/lTw/RxzlvpeHScfqyT++Gd33W/lZTU
 BfEF3Gv5ycspjauCdERE5mHlVZGwzzj6i/0BMqTsPu5qZHzdh2xPlkw=
X-Received: by 2002:a05:6000:46c4:b0:488:8b07:f3f0 with SMTP id
 ffacd0b85a97d-48b12736b6cmr4134973f8f.24.1790949668339; 
 Fri, 02 Oct 2026 07:01:08 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:07 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 00/13] mediatek: add DSI panel support for MT8365 and
 MT8366 boards
Date: Fri, 02 Oct 2026 16:03:51 +0200
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42T24rbMBBAfyX4uVN0v4RS+h/LPujmRE18qWR7G
 5b8e2V5A5tCqV9GDIgzZ0aa9yaHFENujof3JoUl5jj0JSFfDo07m/4UIPqSNwQRgTRW0E2KCr4
 dAoz34HOEPI/jkCZgLQrCtV4iSprCGFNo4+/Kf3nd8jzbn8FNK/TjRgq/5lJ42q411uQAbui6O
 B0PzmBHtEPYWo9oq7TzSmCuLdElsCCJZ9gYvaK6kLOpxsfDt0/CFziFPg5ABQKbYn+aR1g4IKC
 YcWwwFa0WP6y5XaNN4Wsp/f1fOPHof218HN5CAj90Jvaw4AK0UigvsVWau31A/gQ836puF8dYx
 +pTXEqJylZUIhk8J4yYXWyiwV0LLPhopnApSTD9PGZYyKpKtLAtNcxoug9Hn3GnEmFI/uGHFKc
 aY8Ed3TdMwjZgaTiXR7kW2iq3srCjlnslGbM7e32aYzdfY/UsBQZ3+TRGDLy1FlHEQ8vEXvRDc
 0zDaGrfaQ3bsziJxfoTg+U7eBghUh23L8kxAtM/MokQnH0XYVGFTIzwQbqWGKX+Iq+rdI55GtK
 tbu6C6+Z8CP9vSas3waTl2GLJiH2iN6/3+/0PKREhPBgEAAA=
X-Change-ID: 20260918-mt8365-mt8366-add-dsi-support-4f0e6cfd7032
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
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

This series adds DSI support for MediaTek MT8365 and MT8366 based
boards, such as the Genio 350 and the Genio 360 EVKs, in order to
display a boot logo on a DSI panel. It builds on top of the following
series, all sent earlier:

 - the Genio 360 EVK bring-up [1],
 - the MT8365 power domain support [2],
 - the MIPI DSI PHY driver [3],
 - the MediaTek clock cleanups [4], gate lookup fixes [5], single
   clk_ops [6], the MT8365 multimedia clock driver [7] and the rate
   propagation [8],
 - the display component helpers introduced by the MT8188 HDMI
   series [9].

As in the HDMI series, the drivers here were inspired by the
corresponding kernel drivers but were largely trimmed down: U-Boot has
no DRM framework and the goal is only to scan out a framebuffer. The DSI
driver locates the pipeline components through the device-tree aliases
the SoC dtsi already provides, the mutex, which has no alias on the
MT8365, through its driver, and the mmsys through the DSI digital clock,
and programs them directly.

The video pipeline looks like this:

         video uclass framebuffer (in DRAM)
                        |
                        v
                      ovl0                overlay, the DMA master
                        |                 reading the framebuffer
                        v
                      rdma0               pass-through, no DRAM access
                        |
         +--------------+--------------+
         |                             |
         v                             |
      color0                           |   MT8365 only: the colour
         |                             |   pipeline, every block
         v                             |   programmed as pass-through
      ccorr0                           |
         |                             |
         v                             |
       aal0                            |
         |                             |
         v                             |
      gamma0                           |
         |                             |
         v                             |
     dither0                           |
         |                             |
         +--------------+--------------+
                        v
                      dsi0              DSI host, and video mode timing
                        |               generator once the panel is up
                        v
                   mipi d-phy
                        |
                        v
               dsi panel ---> backlight

  mutex0 : hardware SOF synchronization across the pipeline
  mmsys  : routing muxes (MOUT/SEL_IN/SOUT) between the blocks above
  larb0  : SMI local arbiter gating the overlay's access to DRAM

The MT8366 drives the panel straight out of rdma0, without the colour
pipeline: the per-compatible DSI data lists the components of each path.

The series adds the smi_common support and the larb port control to the
SMI driver, the pipeline components (overlay, rdma and the colour
blocks), the mmsys routing and the mutex glue, the DSI host itself
(UCLASS_VIDEO), and the configs enabling the pipeline on the Genio 350
and Genio 360 EVKs.

[1]: https://lore.kernel.org/u-boot/20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com/
[2]: https://lore.kernel.org/u-boot/20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com/
[3]: https://lore.kernel.org/u-boot/20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com/
[4]: https://lore.kernel.org/u-boot/20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com/
[5]: https://lore.kernel.org/u-boot/20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com/
[6]: https://lore.kernel.org/u-boot/20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com/
[7]: https://lore.kernel.org/u-boot/20260925-mt8365-add-mulimedia-clock-driver-v1-1-5fbb0305ef46@baylibre.com/
[8]: https://lore.kernel.org/u-boot/20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com/
[9]: https://lore.kernel.org/u-boot/20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- mtk-smi: only ignore -ENODEV/-ENOENT from the smi_common lookup,
  document PA in mtk_smi_larb_port_set_pa(), MT8366 larbs reuse the
  MT8188 data.
- mutex: no_clk driver data flag instead of ignoring -ENOENT in the
  shared probe, mtk_disp_mutex_ovl_dsi_enable() returns an error,
  SoC-named helpers.
- ddp: SoC-named mt8365/mt8366_ddp_ovl_to_dsi().
- dsi: per-SoC component path replaces has_color_pipeline, match
  "mediatek,mt8365-dsi", .remove() with DM_FLAG_OS_PREPARE instead of
  DM_FLAG_LEAVE_PD_ON so Linux can take over, depend on POWER_DOMAIN,
  drop mmu_set_region_dcache_behaviour().
- ovl: align the CLRFMT macros.
- Rebased on mediatek-for-next, dependencies updated, HDMI v8 [9].
- Link to v1: https://patch.msgid.link/20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com

---
Julien Stephan (13):
      memory: mediatek: mtk-smi: support smi_common and the larb ports
      video: mediatek: add ovl component
      video: mediatek: add disp rdma component
      video: mediatek: add color component
      video: mediatek: add ccorr component
      video: mediatek: add aal component
      video: mediatek: add gamma component
      video: mediatek: add dither component
      video: mediatek: add ddp component
      video: mediatek: mtk_disp_mutex: add the DSI pipeline
      video: mediatek: add dsi driver
      configs: mediatek: mt8365_evk: enable dsi pipeline
      configs: mediatek: mt8366_genio_360_evk: enable dsi pipeline

 configs/mt8365_evk_defconfig             |    6 +
 configs/mt8366_genio_360_evk_defconfig   |    7 +
 drivers/memory/mtk-smi.c                 |  157 +++-
 drivers/video/mediatek/Kconfig           |   32 +
 drivers/video/mediatek/Makefile          |   19 +-
 drivers/video/mediatek/mtk_ddp.c         |  122 +++
 drivers/video/mediatek/mtk_ddp.h         |   30 +
 drivers/video/mediatek/mtk_disp_aal.c    |   54 ++
 drivers/video/mediatek/mtk_disp_aal.h    |   31 +
 drivers/video/mediatek/mtk_disp_ccorr.c  |   55 ++
 drivers/video/mediatek/mtk_disp_ccorr.h  |   31 +
 drivers/video/mediatek/mtk_disp_color.c  |   50 ++
 drivers/video/mediatek/mtk_disp_color.h  |   31 +
 drivers/video/mediatek/mtk_disp_comp.c   |    1 +
 drivers/video/mediatek/mtk_disp_comp.h   |   13 +-
 drivers/video/mediatek/mtk_disp_dither.c |   89 +++
 drivers/video/mediatek/mtk_disp_dither.h |   32 +
 drivers/video/mediatek/mtk_disp_gamma.c  |   51 ++
 drivers/video/mediatek/mtk_disp_gamma.h  |   31 +
 drivers/video/mediatek/mtk_disp_mutex.c  |  133 +++-
 drivers/video/mediatek/mtk_disp_mutex.h  |   11 +
 drivers/video/mediatek/mtk_disp_ovl.c    |  253 +++++++
 drivers/video/mediatek/mtk_disp_ovl.h    |   45 ++
 drivers/video/mediatek/mtk_disp_rdma.c   |  154 ++++
 drivers/video/mediatek/mtk_disp_rdma.h   |   30 +
 drivers/video/mediatek/mtk_dsi.c         | 1184 ++++++++++++++++++++++++++++++
 include/mtk_smi.h                        |   20 +-
 27 files changed, 2642 insertions(+), 30 deletions(-)
---
base-commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9
change-id: 20260918-mt8365-mt8366-add-dsi-support-4f0e6cfd7032
prerequisite-message-id: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
prerequisite-patch-id: 71076a51cdbb0a378913db95aa9ec892aa114510
prerequisite-patch-id: f3c5dac3ef2faa4c107f3972c343798f2890edbd
prerequisite-patch-id: 10d8a4c6afb5d2038385b46eedf6fbff2ff522ce
prerequisite-patch-id: a35f239e99aa1e874cd33547e40a6189f629f2db
prerequisite-message-id: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
prerequisite-patch-id: b507a239269358ce28fd861bfbe83a7e2d37fa4b
prerequisite-patch-id: 3ddafe994065cb677b83cfbc641dd493406c5ebb
prerequisite-patch-id: 6c10fafe32155e48413c3488b0e6ee490c6749ae
prerequisite-message-id: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
prerequisite-patch-id: 35dc9ab519c2e14dbbe2b154bce4e6507e479aa9
prerequisite-patch-id: fc28319e86784585d682ceabba2b6e02e490f8fe
prerequisite-patch-id: 231ff3bc35bd0836302ca9084e7221f29673729e
prerequisite-message-id: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
prerequisite-patch-id: f7d20fd912a63ecd5f74bf715b9440dc51943b20
prerequisite-patch-id: 17573db457a9724fd00a382b6b47041d1e3925b3
prerequisite-patch-id: af5cedd64f7bba7516ad72ed60495245918ba5ea
prerequisite-patch-id: 1dfdabc642d685aec02e163eaaaf316f013f27cb
prerequisite-patch-id: 01db7b89d970b31f8b7f300182c177ef182e258e
prerequisite-patch-id: 2d62bec1fd01c1aaa374796fc331c81c9b86be91
prerequisite-patch-id: f603047a5fe691eb4768638b1dd2c860fcc1093b
prerequisite-patch-id: cc0884d959385c6eda0b1584b9e76d66be401905
prerequisite-patch-id: cb3934029d3adf3d1c67fa93284229476b589e65
prerequisite-patch-id: 4851327632c9d0e57fa8220b619f2f8da63ab014
prerequisite-patch-id: 818bc3d5cf951c4dd6740a681503c29ca89169c2
prerequisite-message-id: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
prerequisite-patch-id: 424ba22478c88e835e3b472126a4a9c33cb4f374
prerequisite-patch-id: bbc80265dc298757bf4eedc6b947e2a091218d6f
prerequisite-message-id: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
prerequisite-patch-id: 46b77492636ad6a60e34f290ed8563dcf4438134
prerequisite-patch-id: 70625bfc712fa2d4b9f27b46c18d4dd58940c5fc
prerequisite-patch-id: 647593cda7ed838507a19315dcd2591c526265e4
prerequisite-patch-id: a56141abdc8666de730c913b072ae174af13217b
prerequisite-patch-id: df75ef6ff7531c8cd25ac2258ac3c5c600886bb4
prerequisite-patch-id: 5e1dc7764ded4b0fd5e999bd75a25884a13ccd0e
prerequisite-patch-id: 92d21ec1e2bdbb1b46f1c74a1917408cfaa865d7
prerequisite-patch-id: 55fb54aebf06acdffcaad16b32560473da088e0d
prerequisite-patch-id: 76645ab8a56e3363ef78c65e59a252a3692e7a86
prerequisite-patch-id: d44379cef68a1817282358087bb4103fd6d86bf5
prerequisite-patch-id: 004b1897736569cf060d929c2d47790edf09a742
prerequisite-patch-id: 0dc729831dc5ebf3f6ce3905db5109e7223db713
prerequisite-patch-id: 88a278a3840d5f9b210f58effe6f5b61126cd5f1
prerequisite-patch-id: 393d77072a0bc5d2cafcb672e6a071226422a253
prerequisite-patch-id: 2b0ea0b5f5e178cf0d2af8c307bc1ffe500f5358
prerequisite-message-id: <20260925-mt8365-add-mulimedia-clock-driver-v1-1-5fbb0305ef46@baylibre.com>
prerequisite-patch-id: 1a9b3e76a306f0f2a31a4af34439f1203bb6f66c
prerequisite-message-id: <20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com>
prerequisite-patch-id: 5b807933cc535ddc432eaea7ed1f5efe8c7a34c5
prerequisite-patch-id: 7acb67f4a3807195fa0bfe534283d70fb36265ec
prerequisite-patch-id: a52d13988616fb3fb25f0695dea06092d64dc4ce
prerequisite-message-id: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
prerequisite-patch-id: 35fb945433e1734704a4cb25ea288d7b5caffb08
prerequisite-patch-id: 88f74bb0bdfb848dc9657970c816837a7d96670e
prerequisite-patch-id: ff4ca6bf61537b47fabb2c7eadfddee5452a384c
prerequisite-patch-id: b4b617dbe24dfc605c886bc53b3748b93d6a9108
prerequisite-patch-id: 5308a23bd0349b5b430b674b607308ab042542b2
prerequisite-patch-id: 0f7148972c2508c27367cd50ef045abbb1a0380b
prerequisite-patch-id: da04e31cc822013abf83eb11e99c96bde6c80789
prerequisite-patch-id: 9230f87412a961d207d93c194c26786b88f2328a
prerequisite-patch-id: dd32ef13b415d318e99dfb82804c2023b215e461
prerequisite-patch-id: 97961b61667804b5e8b4d27554d0eea19f1a7011
prerequisite-patch-id: 5f67de67d6e35a6ff0d6e322fe2aa349d9440723
prerequisite-patch-id: b0a14d18708d59e8cbddbb2c1c29798cae70500e

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

