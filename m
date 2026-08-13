Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00785C5AC67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 911F54094A;
	Thu, 13 Aug 2026 05:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pbd2OYau--CV; Thu, 13 Aug 2026 05:53:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F4F040928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600420;
	bh=X3xgs8KvjMpw1l2HHS00haxbwgkuk3/kTvVChGYdKDE=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=cxfH9P3UNjFfVlWlsMd/vll5ljUTiHjaL1NQWWx7glF+3B3ozuBJUhXyTE2d7/bD1
	 EnQqy8n/VW23CjpK+c0bugJUJxunYSPokR3g/fiCp7r5t8TVLzG7BcRC2HI6ISKpqW
	 WVtOVM4scS5Goar0o5KNzSQk8+4A+nnFg0HoHqPnBl4mFcCTGbpagWCSTZdb1Jxxv6
	 k6okPTZmykEnwkGZleizY44H2DnQlsTUN3beoHTHRn0dqLxSz1kKjAc1qlb9x3KXth
	 an1ojOf81QBd8PehmFqrGjckrS8wJxA7VQhJIDIIxHjiDfwDKvYxPtd7+yzWmZwODt
	 HMmQFjCrOFx9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F4F040928;
	Thu, 13 Aug 2026 05:53:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CBBB744
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A2AA80FB8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dOGTeQGWjYPf for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:53:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8444180F34
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8444180F34
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8444180F34
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g8t61526722
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:37 GMT
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g158g8mfb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so2175078a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600416; x=1787205216;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X3xgs8KvjMpw1l2HHS00haxbwgkuk3/kTvVChGYdKDE=;
 b=Uq8jddsicTbmXqFq4FY6BRsECb4GyWGDBuDyFn5KqFzJ++3/Q7njdjelpW74VKNXYR
 9M5MFBfzZyzwg3odHHhXQlRte55dXNrdUJKE+sbtev9ZTLIJxNzlvKkvVk2CH/JsLs/x
 3Hfd/NUaZnbndxwgeKJZCFvsvY8UGw8fJIZ10vpFPBL/X+BeMw3V23MNsVgJeLZrCrLV
 tb1trIcwUsy92h2WcPcLQpfvCR53jeILEJnJRlnG+senQcTb9pvbBY48w26WBinVHzG4
 hzLUENukSu1NMq1mg3QeDbAXOT6/FCUTZiRuaOmwNWwkvxqTOuygHg6ejvcWc2UbBKlH
 rCNw==
X-Gm-Message-State: AOJu0Yx3qUR7cLNLaghWv/wZrfUXIb7CYvh9bGZO93y8d9p9n3EzyyBh
 SrYDhw7Z5PgG+osmC8xkRq+xUBrf/yyTNV1ea7m20Y4M2enNR1uVjd0odxnbqX6QUuhcCUaM0hb
 8loeLKdXW644vd1ybAdxHiUwHJS6yGOSpiOaQuba3okqEUMmO+mFQjdnmZFiEQuGnglrx0/E=
X-Gm-Gg: AR+sD13JBf1qWIfgEJMOCX3PfNn+rVDkQjY0mMENCkTqg06CPYEQyzrKb6lR5NTMzOy
 iRi5csvRMadu/AK2INJtN20i/8ymXu17zH830UckpQdhdiG9lxzTnObUSD8X7/Lqqi6cxFisuzn
 RJpRjkG7prJ8sANHAKvvb9DE5HstKOOE0zN42Mk84GC86SjlPjvS08e0bGUvC/OX6sWXG6HNqQd
 E0O776iiyGqSvM0ENLV21FUzmhOPo/oyeaQWbt3S6n7WHbaedEsPzSI3uVp2wNivmLrG3S3dR4R
 SKCY/KiD7aOzXel4VffnkGy5HbAqBiwQJgHeO/cnMvKa+p0Hk08m37f9g9Dg/movH+FgXYqIlMd
 7PM5pmdhrKIvo/187j+NUgaNKnREutc+bVjb861FYRbnvfqy9i0aFDaKKv1qEhHNG501XgcyZGa
 YMLBNOZ9p+leWqKXi4cL1MJeFoSA84
X-Received: by 2002:a17:90b:384e:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-3931e075496mr3731701a91.5.1786600416054; 
 Wed, 12 Aug 2026 22:53:36 -0700 (PDT)
X-Received: by 2002:a17:90b:384e:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-3931e075496mr3731661a91.5.1786600415520; 
 Wed, 12 Aug 2026 22:53:35 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebc760524sm3921430eec.1.2026.08.12.22.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:53:35 -0700 (PDT)
Subject: [PATCH 0/2] efi_loader: firmware: decouple dfu_alt_num from
 image_index
Date: Thu, 13 Aug 2026 11:23:28 +0530
Message-Id: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANhbfWoC/x2MWwqAIBAArxL73YJKRHaV6ENyrYWyWHtBdPekz
 4GZeSCRMCVoiweETk68xgy6LGCYXBwJ2WcGo0ytGq2RAmNgWS4nhD4c6OYd47GgNo31jmxdWQU
 53ySr97/u+vf9AD0xmfRqAAAA
X-Change-ID: 20260811-efi-firmware-dfu-alt-num-1289dae96490
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600412; l=2125;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=1s8rOIou3JkSfJNHnDsnbeUhVM95/ypLiafssxWOuQ8=;
 b=NQB4H3+1mh9DFydhb0uPZC6J6t/5s5tcLdfuUwhQIOpJlFmIXKsCiYPvlLDtXUuk3Xyvyfo1M
 DH4J8fAv2ZnDs0qaswUa7KONI2uQXRLMZ2AFKG6YM3Fxq8dgizzmqFQ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 2mP6f1IjWvqeYM68grDENLFlK2Sltomb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfX7xTavlhpgW2G
 8SrYDRp7j2u0WemX7TfRIUg+BP1OStUyxbRuri/L8ZZm0MOpKa5kV8IUVAqJylkOZ2ZajZaN+e3
 ByqxL+YEgE3Ltpwfc5D2E7tLainxsA0=
X-Authority-Analysis: v=2.4 cv=G5ks1dk5 c=1 sm=1 tr=0 ts=6a7d5be1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5HGIanBJfY4LN-7r0dwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 2mP6f1IjWvqeYM68grDENLFlK2Sltomb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfX/k2CkWUgdU70
 MQLAwWyNUTJIE4DcgZSuRNPWwXG81yB+C/fp3ZL8JWp+lJa0P9VfSBDg69/Q80xswgUEL/b9h69
 MshXmb9nuI3TbHgYz2/60lvOtYdSA4bRZVh/i+Zu6Iw6Fv/bmp+IPRgDsnN0e3tLYTc2JY+njql
 QYsyqRqzcwgk1hgim2th8bIj1bYjNRgNO4qy2EJv1oE8OJ6pK2e6cDMiG+pioTV7PkVe8h6Y1Su
 uU4J/zG5GSI32h2eTjO+YZEl4ymRm3ZH/CyPejDRHLJQVt9zFo4pfQbINp68HT7cG44zYZT+tt1
 IV7vvaP/MSOAwMvdUSuqj8Tm96vw1jesWxNpb3Fodf1TV/VPRSJpnWegEJqrZxf4ZPnE8DyEU4L
 B6peVCUqgAkmz7J9VfWRtm4Y8H1s2WrxrVWXrJUYupm2hEZ/fAqNh02gD/uRkw7umD5BnVZ8aQ/
 UjTaN0ZDexUI5i2lx7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130039
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=X3xgs8KvjMpw1l2HHS00ha
 xbwgkuk3/kTvVChGYdKDE=; b=dzta+5/kJb9KRQcQTyIaj7eTnaqzntB0S0+YIZ
 GvaYFblW9ko9J7PT2jzYvyv3HgWb6ass1OoTH5BfhWmomLaLZlxCICGSEbGuFMhR
 4ommiMPpeXmZyIyJrrVuXcGmP7btZQkq9NwqtH3syFwsbDODX98EsS4Zo3NA5TPC
 5KGPzR2y2+I/r+JzusfnatAEPoJdJIV3bCFeG65eTmRa2co0rYWXdsNpKlK60JOF
 ocxh6ifrjQP7MgZyu5ypvaTl3DurDvfi4UT7dF6GnDT7RQGSHdPvcFqRvCIExvba
 lbGQgjKmTrov9zRZqpijAZ6cnfL4aBkHYPUUhNSVITRG+s4w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600416; x=1787205216;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X3xgs8KvjMpw1l2HHS00haxbwgkuk3/kTvVChGYdKDE=;
 b=WYc7nl3s5cOC477qYIhyEWwBYofJIch22kBTyWn5cEZHhQg0w8j8hWjI2oVKsnrL0T
 WaSFqIw2nqYW74Z+EdxY/ox9XF51avZu0CG6hzjeASjHjHm7xnu6E5XI1yHi8H2o4Fn6
 wDLp6C/RgxvzncVqSbgBqtyyfOQ67EHICH5BAo4CwY0WU9kXkXMpM/USHoyOmXek4apa
 qaY7CpcCa71zutmsR52ZJ3VBfa9UPeYL8cZrNTH7IeuvhyG2ncI6nUM5NzajOW50QSlu
 qFT+8tqqaofrM/xHF6s4XwFrDKoS0gh8bNqHjdqWwhUiDPnlJn6vv+a7FNZH5Kjnm1Ra
 MXNw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dzta+5/k; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WYc7nl3s
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

RAW capsule updates hardcode dfu_alt_num = image_index - 1, which
assumes every board's fw_images[] table is a positionally
ordered mirror of its dfu_alt_info string. That's true for every
board that hand-writes fw_images[], but it breaks down for a platform
that builds the table by scanning its partition layout at boot: the
set of images and their indices can vary per board, with gaps where a
component isn't present, so image_index and dfu_alt_num can't be
assumed to stay in lockstep.

This series moves that calculation into a __weak
efi_firmware_get_dfu_alt_num() a platform can override, the same
pattern already used for efi_firmware_get_image_type_id() and the
efi_reset_system()/efi_get_time() hooks. The default implementation is
the same image_index - 1 every existing board relies on today, so
nothing needs to change anywhere else.

This is infrastructure for a follow-on series that builds fw_images[]
dynamically on Qualcomm boards, which needs this hook to keep
dfu_alt_num correct once the table stops being static.

This work is part of multi-image capsule update support for
Qualcomm boards.

Balaji Selvanathan (2):

efi_loader: firmware: decouple dfu_alt_num from image_index
test: efi_capsule: add sandbox coverage for dfu_alt_num override
---
Balaji Selvanathan (2):
      efi_loader: firmware: decouple dfu_alt_num from image_index
      test: efi_capsule: add sandbox coverage for dfu_alt_num override

 arch/sandbox/dts/sandbox_capsule.dtsi              | 12 ++++++
 board/sandbox/sandbox.c                            | 18 +++++++++
 include/efi_loader.h                               | 17 ++++++++
 include/sandbox_efi_capsule.h                      |  1 +
 lib/efi_loader/efi_firmware.c                      | 21 +++++++++-
 .../test_efi_capsule/test_capsule_firmware_raw.py  | 45 ++++++++++++++++++++++
 6 files changed, 112 insertions(+), 2 deletions(-)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-efi-firmware-dfu-alt-num-1289dae96490

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

