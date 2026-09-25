Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB19C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20B8760DA6;
	Fri, 25 Sep 2026 14:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SZxgJumhuLci; Fri, 25 Sep 2026 14:26:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E54E160DC0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346410;
	b=ILmFA6Ng/0uphjykEUZaY0csgWmZVRzH51YJmkEhDJACCWdR6vja2T42+Bv2oA/eWTi9
	 l7iPnoOa/7iZ/XMBq36T2SQXG34rmWqLzG9jW4v23hJHAOLqF++7GTUA/TIvVsLxSmbFB
	 7ABssM5h+5H3786bMuRLBYrrvGCdH6DPUZQjEOLQFcTWQHQ2mfGIOlPVBhwdnJ+Upkyzv
	 5+nNQhi2FGopFhRS4iEGCN1zdrNaxd+/OihWpwlrgL2ZgEOjYoqLtZNN1J4oPbTQN08c1
	 SQAzDhWPkh0aG+qIH7wtA1BTwYhK4pW09qQMBDHIeEvSRq1McP3UfLRFHVxcW2vH3vA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	b=DV/Lf5WQc5cmsAXfEPQi8nRkAFDisdO5pZtSrKgAmg9hrsIDxQADs8VvhKYkyKxRhiCb
	 iIUmF5yNYByyUX2U6tWUJX4EefHf8IRgw4/Gqpw8XFJwLGgTj+XqJ07kyma8y5TNfw15A
	 gUKQRxkNmlgZmNevw/XMDYxNe5PAA5kOD5h+XYzKW2dGtcBNpH5MfewWJyT1My631fjlO
	 n6TLhOAq/klz+r4z2ieYwOvyZLk4LYumOz6pU9O54yPXx3mRfdBiZXCgEps7e+WSfaFgr
	 YJ2+IJvjA7jq3iLO/ezMdaTbOnz6yDf8n8311XShRn/HTNHhEFphmP5Yuqn0pbLabFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346410;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J4aqBPA84eObI+ePBF6WjE8FkyGlzamiq31goBfpUvDEqq0Q37GcR9AvK9RuiGXtx
	 tASAtDxWJMwbM+0W543WMVUIazxi/IVHeIK6QKd2nHrpNOQ5OfEPfMagrjXPYnji/y
	 dMDPOMHDktAW3Y0gmKNlS1ZZYrdCKetBiSXnG3FDk+xCpDQmKfa9q9jy0Kqs83+LJ6
	 RjkAf55JWuddFGmk4WEwwYr4y2c+AhT+wtW3cyuJ889tMcAuodvXPyuFcLVn/p7U8E
	 L+Il7wb/V89Nr0tZ/S50JAmP3oUWv/vL2PLIxgXYkQ+eV78WtNrPT6iy0kSQoy70Ge
	 RvWwry3fz5HqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E54E160DC0;
	Fri, 25 Sep 2026 14:26:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B80B3E13
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D24F40A54
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9IrL5PNMdSGo for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 74845407FA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343501;
 b=ZeNzZOGO6N1R5cQewuxooHVoYe4Nrv4LoDRfez1l+zehJYQ5RlPmPm0+D3xCNVXqZ/aP
 UApXANHCJtplBnPxg6NGBvzT3lGHyRRBQhpx/JoWY3rvzlX4NQukvEg8LKMG8N0nh17XU
 QRNv9VOrI/5OhWCUbmoqLXKWUHjS976kTNBJ56b2kG2722EDvqQca3itWiGYF03Cw1vgQ
 QYX6XY2J2ti+Yp83Z9GftbWScjkzOdi0xJoqXwf4y65klO0oOWpUEgh8FYomiQ2czw8md
 5c+BvLHRNKPV+K96DX0LUL6z1aNvwNj8DvXHB/pcbrEO4K6RBcZEl8W4mBe3+n+Ubiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343501;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=OiLasJLIeYplZV78XQ2VhySfQna5XgV8MpXFTSC1ZRY6zm1TjW+o4VsrWUdy2ayG4x1Q
 ydGUrAL7z+awpeK0dnPfXpqz9fNsMH76wv287APW2Z0RIootexABwCjiWB3v4IjZ05J6s
 2gn6sOU1ycja1/Cj24ezcJTYJjoeNg38LRTjVlQc0c1ktb4QfpM7ohuupM8K81RIpuyqu
 fakYtTDnumpAFGn1GK59hzCKYRA9As3XWqGoRVTeQ61CTNeDYA8ywUpElVVGsU50kAcpg
 akURv4Ste0hc9760NQL5eyGbkFpAR+UbXVUx27dgln3kX7GceNRhQ0DmxvvMs4/AtbQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Jr2L5Ove; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="LXRG/elY"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jr2L5Ove; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LXRG/elY
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74845407FA
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:20 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PD7jNe208631
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8k212rEkKH7
 as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=; b=Jr2L5OveGtFWMu80AjjVErit+Kg
 JVZvPQloigttAZPiRhFOWbFf8pMqpiBVJ4PCkQuENUWR8anTldSw+5EH3aqK7oyy
 q8p1cdRq8cHYEmQtrbpg1hgWCHsTMxGCjcGie6noJLHH+TRUQADIvcxLkeFtSiWk
 d5ac+wsdiNmOHpy/fBsfds3PAtDsF0Qhl9n+6SZ2Ecn67ogRS0CNtjkjVIpVSOSs
 9h0STRWiZGzjvV/QyZ8jr7iFyX64ftf73zNB0cfYeStIdOqq3KMhrmwP/WLDGpRJ
 FgEG+c8rfPoCEZ4+jhCCwZCKFVQLocd7aIQgOPPuBE8tVhEt0YVmhbQgD+Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898upd9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:19 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-14383177746so230799c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343499; x=1790948299;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=LXRG/elYRQ538wziSpTYRt3x3vaA8x7PKv4mEOUyOFFrCMcWgdMDr5w3k29R0pkzds
 LRlYzudjrulJ7H4ghYrwSiqpocFxVeVXk15hfFCHJie/tbOHO39p2ICh/6QDDA8SbCmR
 UvxWxJo3yJcNjmiF+dPisejREHS6cDEfevSlPUFqj+UsEhDSGzgFGp9PT1pK1dCpubTt
 HHVKBkfjULEtpknTrLTM0/hYTcWDlfQqJMmevCwj+ATbvNSsbnj9I0Dk4NY8PBXyVUNz
 +Oy7OehMC77PIbUTfwpVdzPvNAtBMxbFQxYxhCVkH6eJxDTZFszOFacaseaY9koIYBET
 8GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343499; x=1790948299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=YU/U3rtVOQOyuX0k2PK5ROmEQ2lagPVNM0yjCdL+KNPp1E5iibLaB2BlfmEhihGxCU
 OV37Y/XckWKpdumBrXNzUphKGnOImpNJUZ1RjxlM9Qfdh9ohZ09NJRcKtT4sXty9x+H5
 jco9a/XdsZqjoNk4bE4mMfdFMMFOu5HqJtBPoKUxt/Odho02UVUo+UHPJBuDOt/1WpCZ
 pWHQ/T1ZrxTk98RCOdQz7rglrYNG+pO0MWUrHJQ3S0SINf7EefyqsG3QIZKehm5BtBJ5
 RkgvD5qDE+PhmW13MXBZgMapYkdBy1Kijl/0j3Mz5WL9iqe+TPiV1TIF5COoFxGvUqNg
 KrQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4EK00yrxQhSoTKB0tCofs/kgVve3KVYulzMHBvNGviZP9aKugDv9kzynqf+atugBqAtPSCac=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kZabtbqC1U22gp1jXpzpzL+4H5/IjOUNcuYzvDjFVdb6XdBeci
 o76cXOQ/13j9xOoUZZGVocKOwCxHUjk5WQdSZDi5zEwJ+2eF1z9KcFlLizvcV1Yfuc/sCtRC9Hy
 ZYMDw06IypNSueSXCOj6XUw/eQ8bWEqBhh1DmNsSh3tU6scFY0OITz7YeG5hMxbz3lY+u8BQ=
X-Gm-Gg: AYBFou3S2KX1vhnvKkRtaqMwDG5AyWHnQ9NkWVF0OCOgH3B8ikrn+/2aDDjFQTPO2py
 NRF4L6NfJ/xYDfdRVK2jpAm9Z4DzqbaEF4Se9SDilm04KjrG6xMAliL0atqPPy4yODe/SYy0cI6
 Pa2JLH2yPGmZDdPtMCY8mY9YPtUG5Irn7Hs8NjoYnn7V7n6q9ElFMs3cCNw+pEILslY9F1k/zIo
 teiP+gt3iICajB9ZBVyVfESFpt+qcbRaYdPRXWjCE6I3IZfV4BrNNRSKAu/BWDr83m/D4Fh1QrG
 6kJoSlW2ZPQeJUHZJA93GZxOmltHsb9ZkCRYKRqV+yDQsHBELGmuHq3iX+1UxILWDlpDXG8ZtVx
 2nC0Yh3D45FMK3EcG7S95obmjYYnN+z7GrVyaUXxObt4Bu30=
X-Received: by 2002:a05:701b:204b:20b0:145:f4:13ff with SMTP id
 a92af1059eb24-146d077b22dmr274625c88.43.1790343498420; 
 Fri, 25 Sep 2026 06:38:18 -0700 (PDT)
X-Received: by 2002:a05:701b:204b:20b0:145:f4:13ff with SMTP id
 a92af1059eb24-146d077b22dmr274370c88.43.1790343493104; 
 Fri, 25 Sep 2026 06:38:13 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:12 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 04/12] clk: qcom: add configurable FSM-voted PLL helper
Date: Fri, 25 Sep 2026 06:37:58 -0700
Message-Id: <20260925133806.1403713-5-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfXxJPiG7ii4MIV
 5QCu3SfNLn03kr5GaiF2DRIGPhks1EZYS2LuFH0KYNeEbu+ebpAFn90b2adcGGLMHJ16ZN03UpI
 P6APaDvXBh9Xbxt1EG8m3I9uFbAGjmitEkEV2M/DXc83VbzbTa23AaXGqKt3sPi09GCwH7AsuRT
 LApbVQOEH6PkPudrAyjldhfSj2N/Av2l8RU9OEUsYCXyKX8S/NCmTbvI5pbMRwwrUfznYCoGCE9
 utFfxQ5Kismm0CUBOE9nnJX2P8HwuQpHSBmqf6RdM8bP3sXy08mHg9WqfDKdTOCvhFQHbnlcb6S
 ++/sQrxIJVsWlxOn0ckxX/g+kpjPt4rIS/UHTMsxrt7NlPdSYRR4ge8/Lx9oaYFmAVQ9vYkuQdb
 9jZLul+7AHvjuA6AJJKM10Gb+Kw9J4djfk6FNdbtHgzfT/7Foz+fpBDSI4ithON7IWzTCELDhdH
 IZaROVBjjLbVrT90Yng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX4AiyNu2d7B2A
 /NQMiy8x346s5Rp70kxEAxB8ISQSs2oDIKhhCBrlCUwzhkf8U1n1v6+47GsJd1qsJVrrxwQJ+bY
 HJhtFRElEBpKBGH6/JedF6GjKBISfgs=
X-Proofpoint-GUID: AMrDPH2K2-26dnfeD_iaPjasaUqytz2T
X-Proofpoint-ORIG-GUID: AMrDPH2K2-26dnfeD_iaPjasaUqytz2T
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab6794b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=enMxUgKZn3LVR2H3xcYA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Add a reusable helper to configure and vote for Alpha PLLs
controlled by the GCC vote FSM. Per-PLL register offsets
support targets with different PLL layouts.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.c | 48 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h | 24 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..30127c1fffe 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -59,6 +59,54 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0)
 		;
 }
 
+#define PLL_MODE_ACTIVE_FLAG	BIT(30)
+#define PLL_MODE_BIAS_COUNT	GENMASK(19, 14)
+#define PLL_MODE_LOCK_COUNT	GENMASK(13, 8)
+#define PLL_MODE_VOTE_FSM_ENA	BIT(20)
+
+#define PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+#define PLL_MODE_LOCK_COUNT_VAL	(0x0 << 8)
+
+#define PLL_LOCK_TIMEOUT_US	200
+
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll)
+{
+	u32 mode = readl(base + pll->mode_reg);
+	unsigned int count;
+
+	if ((mode & PLL_MODE_VOTE_FSM_ENA) &&
+	    (readl(base + pll->ena_vote) & pll->vote_bit) == pll->vote_bit &&
+	    (mode & PLL_MODE_ACTIVE_FLAG))
+		return;
+
+	writel(0, base + pll->mode_reg);
+	writel(pll->user_ctl_u, base + pll->mode_reg + pll->user_ctl_u_offset);
+	writel(pll->config_ctl, base + pll->mode_reg + pll->config_ctl_offset);
+	writel(pll->test_ctl, base + pll->mode_reg + pll->test_ctl_offset);
+	writel(pll->test_ctl_u, base + pll->mode_reg + pll->test_ctl_u_offset);
+	writel(pll->user_ctl, base + pll->mode_reg + pll->user_ctl_offset);
+	writel(pll->l_val, base + pll->mode_reg + pll->l_val_offset);
+	writel(pll->alpha_val, base + pll->mode_reg + pll->alpha_val_offset);
+	writel(pll->alpha_val_u, base + pll->mode_reg + pll->alpha_val_u_offset);
+
+	mode &= ~(PLL_MODE_BIAS_COUNT | PLL_MODE_LOCK_COUNT);
+	mode |= PLL_MODE_BIAS_COUNT_VAL | PLL_MODE_LOCK_COUNT_VAL |
+		PLL_MODE_VOTE_FSM_ENA;
+	writel(mode, base + pll->mode_reg);
+
+	setbits_le32(base + pll->ena_vote, pll->vote_bit);
+
+	for (count = 0; count < PLL_LOCK_TIMEOUT_US; count++) {
+		if (readl(base + pll->mode_reg) & PLL_MODE_ACTIVE_FLAG)
+			return;
+		udelay(1);
+	}
+
+	WARN(count == PLL_LOCK_TIMEOUT_US,
+	     "PLL @ %#llx [%#010x] never locked\n",
+	     base + pll->mode_reg, readl(base + pll->mode_reg));
+}
+
 #define BRANCH_ON_VAL (0)
 #define BRANCH_NOC_FSM_ON_VAL BIT(29)
 #define BRANCH_CHECK_MASK GENMASK(31, 28)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 9899cd28aad..47930ae9d5e 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -36,6 +36,29 @@ struct pll_vote_clk {
 	int vote_bit;
 };
 
+/* Configuration for an FSM-voteable Alpha PLL. */
+struct pll_config {
+	uintptr_t mode_reg;
+	uintptr_t ena_vote;
+	u32 vote_bit;
+	u32 l_val;
+	u32 alpha_val;
+	u32 alpha_val_u;
+	u32 user_ctl;
+	u32 user_ctl_u;
+	u32 config_ctl;
+	u32 test_ctl;
+	u32 test_ctl_u;
+	u32 l_val_offset;
+	u32 alpha_val_offset;
+	u32 alpha_val_u_offset;
+	u32 test_ctl_offset;
+	u32 test_ctl_u_offset;
+	u32 user_ctl_offset;
+	u32 user_ctl_u_offset;
+	u32 config_ctl_offset;
+};
+
 struct vote_clk {
 	uintptr_t cbcr_reg;
 	uintptr_t ena_vote;
@@ -107,6 +130,7 @@ struct msm_clk_priv {
 
 int qcom_cc_bind(struct udevice *parent);
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
-- 
2.34.1

