Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD999C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 05:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62FA74070F;
	Tue, 21 Jul 2026 05:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yIA6JWMLaXKV; Tue, 21 Jul 2026 05:59:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04DF44073C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784613576;
	bh=hgW2QaJOQ7mEiS7vbErvddZ3ynh5I3izVMJepRHtw5A=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=CZAk/iOBpn2wAw82b3Qxm3DFCgoA8BFx2Fy3UnkPIv+ZmPfmc9caK05fYYrk/bvfR
	 B4PvNNwgwcI4EegDNauGlnlRuH3W6NcjtCizu0E00W+z9Yyrx2zuv/6ms60uCwFCxg
	 Q7GV7+zgVjv3aIPxe0S4b/emIxEdP3ke2eFcPQUHTN9dHDdrbCkmPb7ZC20cvuN/dD
	 0g2jZMnEjZDsB7sVBVVzIU+kL9WqAVpW5DM3R9O19Z340FYLVnGKifO/jLyqlnb3RP
	 ztr5IiubiSeDON8WEqXWgYFlpGYpIbRjypCfOQg49/EQO8vzJLEn7oErDM1ZzDlmNY
	 FKJQJLK/HB0UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04DF44073C;
	Tue, 21 Jul 2026 05:59:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 811839E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 674FC400BB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id An_AQoxFn9Yk for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 05:59:33 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4D0E2400DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D0E2400DB
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D0E2400DB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:59:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563D6844F6; Tue, 21 Jul 2026 07:59:31 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508C6803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 07:59:28 +0200 (CEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L4T2pL528065
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:59:26 GMT
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se09t0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:59:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso7290522b3a.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 22:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784613565; x=1785218365;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hgW2QaJOQ7mEiS7vbErvddZ3ynh5I3izVMJepRHtw5A=;
 b=Mdpx6wRvruK9YzM+80sDWXpfkkG94/mTLKk5rj51y/OjH63WiGv9yPuvhlcuVX8yJO
 0ipMZWV7zPkdKpeD1oYseNj4ycTWACr/HZcFUvC6qORg9fiopZqq3zJQveybdBpegyBj
 iHnSrcAq3QLQyjReS16dkwXMW3+cuKMXieAKqiwP1krqHTfZu54z8GQSmSAm7EyiReR7
 9vRQQ8JhJbxfoazPZ8GdKxF6erAbug1BYfqMrrfAGIRP+Y8LuXkmNXTQu+6eVCoQBK4h
 9anXAxO7Ri55vg/mA6PoB6bSkQ5f8tNdg96Hg5lZ/KqF96NfJe+JECsqGKJGFZZKtkrx
 JsTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNoyeANyD6KkDSD688jk8k1iFMZdlwPJ/9rFWH/70dKskGjFFi8Cp+dFYpHsWxYFs50kTXx2c=@lists.denx.de
X-Gm-Message-State: AOJu0YxTbtLgQlnIbGr4kL8G+VtSRZXZ/lFg8gj+hzdeedNfsLtuSOWO
 n8CTojaXrC4GvekNvQhW6eFHrp1KrB4h0C2Uimiow6uXVGZ8rOXtE1s7F571cniyF8Fpl6TMkXS
 MU1Tau2lZN5w/DyTrTv3WFSnpASTkXksiorLaBaMhq3EOYkmHmt/4sdsK
X-Gm-Gg: AfdE7clg4fIW+Hi2/Rh0KCtdLc8XWSZtEuMTS5vrTjSJU+YdPO44DycCWu2acO9/Lo8
 OIa6OQHKs8C1DERBCJIUgQmhNa9DR4NeF01g8MlaH2XTxf1WBvli3ovTw7WgVavMiT7uExozikt
 PiPUfV8SybOz26iSu2bziu567YRYui2itAJkOrjKcYCNwesGMslBsQtoGwuiH71yZtzvbMu5J4G
 PpiUZB/dOBphcqjsoJK/OwnhQzsTLdMRE9ID8S3H2pIsNHaXJq3I19JCbn1JaUVhhpmx5c75L8s
 qeWj8nCoKNGnmVYV7677zNDbrk+MhsAp/UwrR1egX7bm8zqcTXYflCSo33BseIea0fsLlwxpVgi
 ggD6srCwuZLAkgnRWVKTl10S9C0B6q5gQCcA/dQnfckCreOwU1kR6xUGkavvEFr5h4rWfyrFVns
 CCpBayleFUzzwwxxwxAilCXP3ih/oOGQ==
X-Received: by 2002:a05:6a20:c70b:b0:3b4:cd6:88b with SMTP id
 adf61e73a8af0-3c3ada1e7d0mr18027119637.46.1784613565277; 
 Mon, 20 Jul 2026 22:59:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:c70b:b0:3b4:cd6:88b with SMTP id
 adf61e73a8af0-3c3ada1e7d0mr18027093637.46.1784613564717; 
 Mon, 20 Jul 2026 22:59:24 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2cbb69bsm31994949c88.11.2026.07.20.22.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 22:59:23 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:23:34 +0530
Subject: [PATCH v3] misc: qcom_geni: Add minicore support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-minicore-v3-1-172e5f28138b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAF4JX2oC/22OQQqDMBBFryJZNxLHJqKr3qN0EdOxDlRTEw0t4
 t0bdSO0DAR++O/NzMyjI/SsSmbmMJAn28eQnxJmWt0/kNM9ZgYClCgywTvqyViHvJZ1AVCiahS
 yWH85bOi9qa63PTscpmgc909Wa4/c2K6jsUoAQSk0EgrD1npLfrTusx0Ssq3/uzNkPE6JWkhzz
 oQWF+t9Okz6uWrT+GyuAEdeHXhYeSV0I2VZQ5H/4Zdl+QILZT69FgEAAA==
X-Change-ID: 20260710-minicore-b5b7229e6f6e
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: F9y0i0JipC5P1jADAwxo3hIS5DUpesf3
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f0abe cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=YfCOm-DyAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=cm27Pg_UAAAA:8 a=BfythxBcQSHFQHQnXvEA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2MCBTYWx0ZWRfX7MOYtznPumm8
 AVjRAEoUGtQu++QjEsQaCuDb7gfgSghj/580euyftjGh5YT3w5k1/GrMrr9jqMI9HsjQwGk7fMf
 v3V205NtWv7VBZim2HM6tW5mj1fVgv0=
X-Proofpoint-GUID: F9y0i0JipC5P1jADAwxo3hIS5DUpesf3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2MCBTYWx0ZWRfX46/Bk72v+JIY
 Pmm+RF2qVM1PaKMUjwUANjAl6tlV51XfMFHcT8aOt2Ed2WwqYgvcLe4EivTG5pxfr7X+Y+0nseM
 RP6M3ZeZB716GX7Vm7YPzjGdYOhmzdCNN5Y1Hk2Idr8BGXRTP5viZ0krbEhDAZK/i+GuaynYGb2
 eugmZQajmspURE506bf7s35FmpyyT0bkYT9BUz7i34rvuwTnm9XkodFuiZ+FgRGp2lYn/urmEcx
 1NACCPppkkKFZdLxqU1GCrSHmkZXrtEAECtvtpZHpiyTVyJXyGisveLPD5owJMuL3wTMEHLiqxz
 WVA+/6YlFaY7hbqlJMU0cc/hRlNLOJniXi8NRMlrk5LH7JsALFzhzOALXsnOkwmxfhyNbLS6H55
 ViFFKT5JM3ox03z20vwzn+Yvp14/d9QajvCZI6y5GPijoAgg6e3PDe2xq3Ydz+k0sdbx0rrikFA
 u2D1yFOtM1oK3roKvoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210060
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hgW2QaJOQ7mEiS7vbErvdd
 Z3ynh5I3izVMJepRHtw5A=; b=MWLEO2u1cb4Gu08LTjNTzpTL7koq2i93RnDeVR
 CfJ71r5XS1N/gmcUK+DbOjQ1E1hKxBb/Rw9zBLJjYB/ScqMHl38yqRH8SrfjGLOU
 JLuZEbYopHDyDPZQ76tQf7eo3Ldt0fKi4cqJMgL07unnd1LgqMkNCACgLe6Jlp38
 VbdbLGm6K5vlsBfpXpj6Fn9WHgokulyu7LEQjzD77VcF0p5qtekvH/xTFhmggyXp
 Hx8SUgeAAtO8G6taRcJfnNvPSsfcxinKjPuY0ZN6zH783/MkaKqXZXeltwmFzkpA
 LjNmW1Y1usZ0h8jSsIK/to3Bq0Hb6yz/jGWXry5v8Kj+oFxQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784613565; x=1785218365; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hgW2QaJOQ7mEiS7vbErvddZ3ynh5I3izVMJepRHtw5A=;
 b=jdkM7m754bqANQZkKy3Ifpta+OUVWVmwU/yQDM/Lr6COhj8RqqX/GRMH+5GHHrOO6V
 QrBSniCAOYq4nW/Xgx8FwPhzutIo8kIdvoG8TCSUjQGiYCvHd4NnfZAtWxocxaSipjs6
 DLJNIgdUbPl95MvLISVHOuxDdC1UKrFzBMEg4gIssKP/PYriMt4y6A0bnZ/8ZiHbnNxf
 DisupRbAPcrupE+80EqwzqjaCYcG/hnd273wyuSexh9T5k6ZTG06C+xtNKj1/Y6UaSt1
 +TgKh4nUN47FIjoolQR8cNAp5TTWUsJQ3k6UHHdPVoG4vFcCyjHbacJJDagod0Crqp9T
 1KDw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MWLEO2u1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jdkM7m75
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MWLEO2u1";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="jdkM7m75"; 
 dkim-atps=neutral
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The qcom_geni driver reads an ELF from storage and configures a set of
registers and programs the firmware to the GENI Serial Engine (GENI-SE)
wrapper device for the expected functionality.

Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
wrapper is pre-configured for one of the functions defined in 'enum
geni_se_protocol_type'. Hence, the firmware download is not needed.
Only the register configuration part is needed.

Earlier, the boot stages before U-Boot would configure the GENI-SE (to
access UART/SPI etc). Since for IPQ5210 U-Boot SPL, the previous stage
(i.e. boot ROM) doesn't do that modify the driver to do the register
configuration part alone without reading an ELF from the storage.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Address the feedback in [1].
	- Separate out minicore related changes from the SPL changes
	- Avoid CONFIG_QCOM_GENI_MINICORE check in multiple places
	- Move struct qup_mini_core_info and related defines to separate header
	- Undo changes w.r.t. EVENT_SPY_SIMPLE
	- Rebased on https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
	  to use Micheal's EVENT support in SPL

1 - https://lore.kernel.org/u-boot/9f40675f-e39d-4849-a6f5-7dcd7aeb251a@linaro.org/
---
Changes in v3:
- If QCOM_GENI_MINICORE is not enabled, #define qup_mini_cores as NULL
  instead of declaring a dummy variable set to NULL.
- Remove duplicate definition of GENI_OUTPUT_CTRL from qup-fw-load.h
- Link to v2: https://lore.kernel.org/r/20260716-minicore-v2-1-160af559b273@oss.qualcomm.com

Changes in v2:
- Missed to 'git add include/soc/qcom/minicore.h' in the previous version
- Link to v1: https://lore.kernel.org/r/20260710-minicore-v1-1-19ea05c410a0@oss.qualcomm.com
---
 drivers/misc/Kconfig              |   6 +++
 drivers/misc/Makefile             |   1 +
 drivers/misc/qcom_geni-minicore.c | 103 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/qcom_geni.c          |  85 +++++++++++++++++++++++++++----
 include/soc/qcom/geni-se.h        |   5 ++
 include/soc/qcom/minicore.h       |  25 +++++++++
 6 files changed, 214 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index bde5c640de8..0b7894f131e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,12 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_GENI_MINICORE
+	bool "Support minicores in Qualcomm Generic Interface (GENI) driver"
+	depends on QCOM_GENI
+	help
+	  Enable support for minicores in Qualcomm GENI and its peripherals.
+
 config ROCKCHIP_EFUSE
 	bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..2daccbba74d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_QCOM_GENI_MINICORE) += qcom_geni-minicore.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/qcom_geni-minicore.c b/drivers/misc/qcom_geni-minicore.c
new file mode 100644
index 00000000000..12c57bdd8b2
--- /dev/null
+++ b/drivers/misc/qcom_geni-minicore.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/minicore.h>
+
+/*
+ * Register configuration for the QUP minicores to setup the corresponding
+ * functionality of SPI/I2C/UART.
+ */
+static u8 cfg_reg_idx[] = {
+	/* 0 to 18 */
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+	/* 64 to 113 */
+	64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
+	81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
+	98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
+	112, 113,
+};
+
+static u32 spi_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00240E78, 0x00011088,
+	0x00240007, 0x00000000, 0x00000000, 0x0001000A, 0x00000300, 0x00000000,
+	0x00000000, 0x00000000, 0x00154400, 0x001483A0, 0x00AA8128, 0x00641002,
+	0x00004000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FE05, 0x0002C2E7, 0x0A435C00, 0x0010011A, 0x08800000,
+	0x00000000, 0x100CAC00, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x000018E4, 0x00000000,
+	0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F807, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x00000004, 0x00000009, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C0033F, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 uart_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000024, 0x00000000, 0x00000024, 0x00000000, 0x00019A00, 0x00400000,
+	0x00E00000, 0x00010020, 0x00000000, 0x00000000, 0x00000300, 0x00000700,
+	0x00000400, 0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00C00024,
+	0x00000B00,
+	/* 64 to 113 */
+	0x00020231, 0x0000CE05, 0x000360E7, 0x0941E6A8, 0x00100510, 0x42C01E51,
+	0x00000401, 0x002E8400, 0x1694581A, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x0000031C, 0x00000000,
+	0x0000000F, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00081C06, 0x00004010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x0000000D, 0x00000000, 0x00081C06, 0x00004010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00C02415, 0x0000000E, 0x00000001,
+	0x00000001, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 i2c_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000090, 0x00000000, 0x00000090, 0x00000000, 0x00038028, 0x00084080,
+	0x00000343, 0x00010000, 0x00000000, 0x00001A00, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00808008, 0x001C0020, 0x00000000, 0x00020000,
+	0x00000000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FC01, 0x00036222, 0x09C01FFC, 0x00100120, 0x02C00000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000409, 0x00000003,
+	0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F8FE, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000001, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+struct qup_mini_core_info qup_mini_cores[] = {
+	{
+		.serial_protocol = GENI_SE_SPI,
+		.fw_version = 0xb02,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(spi_cfg_val),
+		.cfg_val = spi_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_UART,
+		.fw_version = 0x405,
+		.cfg_version = 0xa,
+		.cfg_count = ARRAY_SIZE(uart_cfg_val),
+		.cfg_val = uart_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_I2C,
+		.fw_version = 0x204,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(i2c_cfg_val),
+		.cfg_val = i2c_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_INVALID_PROTO,
+	},
+};
diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..f3133f85885 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -21,6 +21,7 @@
 #include <linux/printk.h>
 #include <soc/qcom/geni-se.h>
 #include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/minicore.h>
 #include <dm/device_compat.h>
 
 struct qup_se_rsc {
@@ -34,8 +35,11 @@ struct qup_se_rsc {
 
 struct geni_se_plat {
 	bool need_firmware_load;
+	bool is_mini_core;
 };
 
+static int qcom_geni_fw_initialise(void);
+
 /**
  * geni_enable_interrupts() Enable interrupts.
  * @rsc: Pointer to a structure representing SE-related resources.
@@ -163,16 +167,54 @@ static void geni_config_common_control(struct qup_se_rsc *rsc)
 		       COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
 }
 
-static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
+static int load_se_firmware(struct qup_se_rsc *rsc, bool elf, void *info)
 {
+	struct geni_se_plat *plat = dev_get_plat(rsc->dev->parent);
+	struct elf_se_hdr *hdr, tmp_hdr;
 	const u32 *fw_val_arr, *cfg_val_arr;
 	const u8 *cfg_idx_arr;
 	u32 i, reg_value, mask, ramn_cnt;
 	int ret;
 
-	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
-	cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
-	cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	if (elf) {
+		hdr = info;
+		fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
+		cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
+		cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	} else if (plat->is_mini_core) {
+		/*
+		 * Minicore controllers come with pre-configured functionality
+		 * and don't need a firmware download and just need the register
+		 * configuration. Hence, skipping the firmware part and setting
+		 * up just the register configuration related information.
+		 */
+		struct qup_mini_core_info *qmc = info;
+
+		for (; qmc->serial_protocol != GENI_SE_INVALID_PROTO; qmc++)
+			if (qmc->serial_protocol == rsc->protocol)
+				break;
+
+		if (qmc->serial_protocol == GENI_SE_INVALID_PROTO) {
+			dev_err(rsc->dev, "Invalid MINICORE protocol (%d)\n",
+				rsc->protocol);
+			return -EINVAL;
+		}
+
+		tmp_hdr.magic = MAGIC_NUM_SE;
+		tmp_hdr.version = 1;
+		tmp_hdr.serial_protocol = rsc->protocol;
+		tmp_hdr.fw_version = qmc->fw_version;
+		tmp_hdr.cfg_version = qmc->cfg_version;
+		tmp_hdr.fw_size_in_items = qmc->cfg_ram_count;
+		tmp_hdr.cfg_size_in_items = qmc->cfg_count;
+		hdr = &tmp_hdr;
+		fw_val_arr = (const u32 *)qmc->cfg_ram;
+		cfg_idx_arr = (const u8 *)qmc->cfg_idx;
+		cfg_val_arr = (const u32 *)qmc->cfg_val;
+	} else {
+		dev_err(rsc->dev, "Neither fw nor register settings found\n");
+		return -EINVAL;
+	}
 
 	geni_config_common_control(rsc);
 
@@ -350,8 +392,9 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 {
 	struct qup_se_rsc rsc;
 	struct elf_se_hdr *hdr;
+	bool elf;
 	int ret;
-	void *fw;
+	void *fw, *info;
 
 	rsc.dev = dev;
 	rsc.base = qup_base;
@@ -377,15 +420,26 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 	/* The firmware blob is the private data of the GENI wrapper (parent) */
 	fw = dev_get_priv(dev->parent);
 
-	ret = read_elf(&rsc, fw, &hdr);
-	if (ret) {
-		dev_err(dev, "Failed to read ELF: %d\n", ret);
-		return ret;
+	if (IS_ELF(*(Elf32_Ehdr *)fw)) {
+		ret = read_elf(&rsc, fw, &hdr);
+		if (ret) {
+			dev_err(dev, "Failed to read ELF: %d\n", ret);
+			return ret;
+		}
+		elf = true;
+		info = hdr;
+	} else {
+		elf = false;
+		info = fw;
+		if (!IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {
+			dev_err(dev, "Error: f/w ELF not found and minicore support disabled\n");
+			return -EINVAL;
+		}
 	}
 
 	dev_info(dev, "Loading QUP firmware...\n");
 
-	return load_se_firmware(&rsc, hdr);
+	return load_se_firmware(&rsc, elf, info);
 }
 
 /*
@@ -414,6 +468,9 @@ static int geni_se_of_to_plat(struct udevice *dev)
 
 		if (proto == GENI_SE_INVALID_PROTO)
 			plat->need_firmware_load = true;
+
+		if (readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES)
+			plat->is_mini_core = true;
 	}
 
 	return 0;
@@ -473,7 +530,7 @@ static int probe_children_load_firmware(struct udevice *dev)
 		ret = 0;
 		/* Find the device for this ofnode, or bind it */
 		if (device_find_global_by_ofnode(child, &child_dev))
-			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);	
+			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);
 		if (ret) {
 			/* Skip nodes that don't have drivers */
 			debug("Failed to probe child %s: %d\n", ofnode_get_name(child), ret);
@@ -518,6 +575,11 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+	if (plat->is_mini_core) {
+		fw_buf = qup_mini_cores;
+		goto mini_core;
+	}
+
 	ret = find_qupfw_part(&blk_dev, &part_info);
 	if (ret) {
 		pr_err("QUP firmware partition not found\n");
@@ -544,6 +606,7 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+mini_core:
 	/*
 	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
 	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index fc9a8e82cd8..3063b37010d 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -77,8 +77,12 @@ enum geni_se_protocol_type {
 #define SE_IRQ_EN			0xe1c
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
+#define SE_HW_PARAM_2			0xe2c
 #define SE_DMA_GENERAL_CFG		0xe30
 
+/* SE_HW_PARAM_2 fields */
+#define GENI_USE_MINICORES		BIT(12)
+
 /* GENI_DFS_IF_CFG fields */
 #define DFS_IF_EN BIT(0)
 
@@ -248,6 +252,7 @@ enum geni_se_protocol_type {
 /* SE_HW_PARAM_0 fields */
 #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define TX_FIFO_WIDTH_SHFT		24
+
 /*
  * For QUP HW Version >= 3.10 Tx fifo depth support is increased
  * to 256bytes and corresponding bits are 16 to 23
diff --git a/include/soc/qcom/minicore.h b/include/soc/qcom/minicore.h
new file mode 100644
index 00000000000..f36c3d2c5fd
--- /dev/null
+++ b/include/soc/qcom/minicore.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _SOC_QCOM_MINI_CORE
+#define _SOC_QCOM_MINI_CORE
+
+struct qup_mini_core_info {
+	u16 serial_protocol;
+	u16 fw_version;
+	u16 cfg_version;
+	u16 cfg_count;
+	u32 *cfg_val;
+	u8 *cfg_idx;
+	u32 *cfg_ram;
+	u32 cfg_ram_count;
+};
+
+#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+extern struct qup_mini_core_info qup_mini_cores[];
+#else
+#define qup_mini_cores		NULL
+#endif
+
+#endif /* _SOC_QCOM_MINI_CORE */

---
base-commit: 2e266ec527c20dabd53dc1b19950ce5b77cf2f24
change-id: 20260710-minicore-b5b7229e6f6e

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

