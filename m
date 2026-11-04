Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CEC606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rMLHXSwW;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HjVesgOf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gq9Ad4T7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CC7F40386;
	Wed,  4 Nov 2026 16:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rca377LHLz4E; Wed,  4 Nov 2026 16:34:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E08A040514
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810085;
	b=KwECiOyTV3IFsoin5r9Qx8eFLiW+uS7F+5pepls8SYB3QZKqJbssxYu72Hk2PcU+7XvN
	 QNfn4bgogfLI4AhEwT5zckHPk/g+yXzrMSfnvAb1Ucjab2HBXc6R72+YEeKR6TJY4dHKy
	 WXE0xd21cF14T0cqTzSHhfMJPqqi0Uh9gRp7N1pR5BgWJeIM3kZ2otArcc60Lvh4SrEQa
	 B8AkWcoM5ddUYO2kCJOCJUXXe5ifTFIVnrU6TYEqOpkG1uYIJg1H4ckDZblNCM0gNn4Iv
	 ASF1BISj34mNKWz7nrg7AZ8lIf6LbQVQ0ITXrw2S3JHz4pzLjAvWBJ50pC9hpZWW8hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810085;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AXJDaag3cxZQSF3w/NYBUCDRHNivZQB6hc5gGjAykWA=;
	b=bDT/CXE7rJVbZpT/McfgfW4hNxvITYgUIzWMylXLPhj72G416bQ+udgHsg2uDEzMA9YZ
	 l+m6kZtsVJuYTc0ZowRVZePxiuvTmPcBGcaprE59sNjN84cfov1zYcjoy0ukXiUszScw4
	 6HiygGuVkrnKTwK6EdARsFa6NvvOb4FtR3gfe6xcEPeMhYeYj5319nS+bFtALpvPu/Qzg
	 OXaZdu6vcV2dkAjbOoDpmPu2dg13HAE7saXgYjT+JttkHfwN7uiid0d96GZd7PLTZvCjD
	 MeS1ptTBTFWJGkMEoQ3wnauOuUw9wrTAmOvQT2OGFZJq6JbjDVFXk7IYuSipabw98Ig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810085;
	bh=AXJDaag3cxZQSF3w/NYBUCDRHNivZQB6hc5gGjAykWA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rMLHXSwWG2GbZG6G9akNt/lm8gKUMs8iwqiwu0yYtsZuB8LEyh9UWDM44NzLA2EhE
	 b3XhAvIGl0t4hRwfuyPmI6eWwKNh8rCIxGIjiqLsR44XbONh45NeddsBk3L+3E4B0z
	 oLnaTWI7tvcU5mBp17tBNZcEpvPpdcfz6Edu32kYVlZQGBGJ5k9vtCq1kUYqjTpAzb
	 1B2dCdrDiDUiq/46lx7Th8i64lG8M2jgYnj5Z2wTQ4WXS+3rB27PELDGerDi/kEEKK
	 tRUVgHjYkLl9zSOqJQTKU00TrF9CyH1CW81eKMlWLTipiBej/AwU3UGq5QSBQMbqzU
	 xl8hzG7N0RhnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E08A040514;
	Wed,  4 Nov 2026 16:34:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3174A165
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1750060642
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mo6kVGH4VxN4 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 55D0B605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HjVesgOf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gq9Ad4T7
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55D0B605DF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:41 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj7Pw2853363
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AXJDaag3cxZ
 QSF3w/NYBUCDRHNivZQB6hc5gGjAykWA=; b=HjVesgOfUeKbi/MrO60Dq4JA2ha
 0DjouKigdFrohV5xSsSrel70sblfs0VCiO8WhLNLAtOVwsHgRWcXqixx6wyPKPSr
 G9OYCwPnn6YQRWBqyCGbGM5ziTYkx9eVLsk577jboPkTYufQbq3Zb/IpIpoLkNPR
 U8g7hjz+WwHr9NtCXAjdW/vbNHDg0eCtE5KNaE/HQcezYAYQjfq78MzAtOgft2mS
 gjmnbfEGxLxlu+n2MkytAxKHmoXZ4NL/RyQWbz6+0k8IxfH8HEhP+WKtjj8HiHqC
 BY5TyJRL2i5l1Yg1E9zRzIjtDpUmYXvNiA/732QFqyiJQL+bZEOomb96JWA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8mvtun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:34:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36c9e87d262so1249582eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810079; x=1794414879;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AXJDaag3cxZQSF3w/NYBUCDRHNivZQB6hc5gGjAykWA=;
 b=gq9Ad4T722EVJeh2nurvaqQNUnJYjz6bdWrzcjeHj7gQ/oyow+9KNWAxuL8Qq76WKb
 EuFYfXWcQkuYH/rcjG0hJA9Y2jc3ig0C57In3/W4ybU69b9B5XHTIFGo5yWanoCSLYBD
 nWyo+s1RmBGdYLRgBU1TSLBnuX7U5p6ll1ujTahOGxl2b/9O2Vf+0W86pKFuduSnj4jS
 wHls7+P485oINpHLf/DXizxofXnH3AmHaOgK3wNVY+O/iVezHcv4JPiEM8Vgsoa0VhS3
 FmzkWZOH9BdnHNdosRbCX82yPP260DiBmFR0HqSs/2Ynd4Bf02+bueAESP6WD68X/1wW
 o8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810079; x=1794414879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AXJDaag3cxZQSF3w/NYBUCDRHNivZQB6hc5gGjAykWA=;
 b=uM/6R8217Z0guPPSw/TTmdMbTXXfRgoeXAQzkHzkSlgQsjxg0IHpGPAPpN/CNzTBlk
 jqNe4/fJwTHPI2txvNFJlsycftX1R9xAtFHpyzo1U/y8kdlbsxoOkM/zUjgGhigPP6OZ
 FXSPKIc1g1+76lqa+Q7lxw4O12SILJ5R7DwVAZNA4a9kY/7gjhMz2Uyhj3KhZM06XBaX
 B+Dor4EUWse42u4VYBLR3S8qf7X/qyQCCs1mHNMIzH53zFSKpJJgVv4X8pWU4P3burH5
 f/iPAPAcBp9mMTZ0a5vsPNbWiZ+95dApH8RglkKDwb05xAv9TzMJEAWUFTyjYs8zWdo7
 OLYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRBFcstU9/HslVDxurmh61Bvyy3e4kGNXBAEPAXAopIdsxBpqPSP0bZzRNxcgh45kzidVA2Lk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z82NP+1deMf3gzHHrPn8QGDFtOshOIkMAHcReGP2vhHVfx1TjSo
 EHvm3s2njdl9w5GVsO5DTGKX+Mhi2k5s6J47P25wcv+ZYCuuTmtY3M5IUHa3RTkR5k0gEPQbDII
 WQiRFXumyCA9iLR1JVOukWGpn71wGAtF1vYekFfg3BXXjkDiMbsJRjAlA17mfkqKy7ClKd3c=
X-Gm-Gg: AYBFou0iUiEOxiD1h1qaXU0+rCY0kim6PBRHWjwfJdRPPEd6yqnkehKCtBkiiillbbh
 Ya90jLWg6NFK9P6aukPYgP+YISJwE/fZqe9NRfdwyB+lR/7c0yLJEEXjgjIhhNejcEWJuOYFavC
 +kb2F7aAYQ6oJkYsIQQ4p5NSLgEjPbzT62IrBQw4xNBsH6u30AN8OjhQ/p6vdNx52TUb+H8F5K7
 vhEUk9CoX8wC1oDV7yyHUkYxdmROu68ASrPsS6nKyAfqaWMZysmRu7Us9DHdZlay1Fgr48pLtVF
 BZhwPhFDF4XxC+02L6ahrKevQEdR7vLqR6qeFVSr3MqtaM7TCVoJI9M7AEy1toQ0Nev1C7RCFt+
 AIxbqhP97GBl4QX7rpBLRHnApS9th9zSOmtL5aeHEHy1fMccLuUYem1XYC2qwx8r4PqNNc+tpIM
 0wehrQcoL7gxMwyK2YJgYqXQ8j82mDN6UNJ/gLoB5kdAoE9C7S/K5qUQqDp9kWXUWJ
X-Received: by 2002:a05:7301:618b:20b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-36a4241b070mr22566272eec.30.1793810079118; 
 Wed, 04 Nov 2026 08:34:39 -0800 (PST)
X-Received: by 2002:a05:7301:618b:20b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-36a4241b070mr22566240eec.30.1793810078544; 
 Wed, 04 Nov 2026 08:34:38 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:34:38 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/9] pci: pcie_dw_qcom: configure an inbound iATU window
Date: Wed,  4 Nov 2026 22:03:51 +0530
Message-ID: <20261104163408.1250410-3-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xrHF9wk2iUPz5bkH0Qsm4XOJSmsZxISQ
X-Proofpoint-ORIG-GUID: xrHF9wk2iUPz5bkH0Qsm4XOJSmsZxISQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX+luDY1WcNMws
 iSo3NoYGNccqeqE2mzTnpfna+E0zZHIY7bn7PIfPldV+d8EvqSFHsDy9G8fkAzzz5iJ0HPKbFJx
 g7Yg7KpA0AUTLlVIAhsfnCmG/CO6HmtuNJk3vsSuXXJXLg3mRzXR5or75UyAA2JlLQRuG3J3eWT
 TgQPAJTIPxKUI/cFibfPP1dEUcOpFLgV6IOv4vLPnBlmdVpfQYQGDd4JPZ6tqU9FW+nHcepAzGo
 9ilh+rMNeTcScYl2s27uXCpMj9+IyhGHSNzLM/SKRfy/rPDoQJMxQotGAUbHFOi3fLUbUXaJgP3
 Xnb0dMxLQmky79P3en8PIkXA82ncT6x0zWVgAReTiWldk2nrpM3qDGuH10hkTy3V7uHW8enc/xX
 1IXI5bsxO/S1SYlShdZzC2PMEuxyL2rj1tyjFP0I0kZw6sW4/sWsAkMK0fV8rfFiASQXTlNXOyp
 bLw64T3Mh9HC1yu45nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX8qSaEOwBEjYJ
 RMBwUTzIsBspb4LMljKoytE/kgD2FrqJqQbhxj9OP2O/nuxIvERI9+qFGSQL/T0Rkjmnd8m3bdR
 O3Faqg/NaJAmaD2xIc0v4b5TpB8yQ6E=
X-Authority-Analysis: v=2.4 cv=HbWB3SE8 c=1 sm=1 tr=0 ts=6aeb5ea0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=AesQuYKOYhzTj5GBKvwA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040065
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

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

The RC leaves every inbound window disabled, so inbound Memory
Read/Write TLPs from endpoints are dropped, resulting in a
Completion Timeout.

Configure an inbound iATU window via pcie_dw_prog_inbound_atu_unroll(),
sized from "dma-ranges" (via dev_get_dma_range(), which also picks
up an ancestor node's dma-ranges). Fall back to a conservative 4GB
identity window with a warning if no dma-ranges is found.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/pci/pcie_dw_qcom.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index ce6b4d97d1d..1215346bcb4 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/log2.h>
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 
 #include "pcie_dw_common.h"
 
@@ -484,6 +485,9 @@ static int qcom_pcie_probe(struct udevice *dev)
 	struct qcom_pcie *priv = dev_get_priv(dev);
 	struct udevice *ctlr = pci_get_controller(dev);
 	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	phys_addr_t cpu_addr;
+	dma_addr_t bus_addr;
+	u64 size;
 	int ret = 0;
 
 	priv->dw.first_busno = dev_seq(dev);
@@ -507,12 +511,32 @@ static int qcom_pcie_probe(struct udevice *dev)
 	else
 		printf("PCIE-%d: Link up timeout\n", dev_seq(dev));
 
-	return pcie_dw_prog_outbound_atu_unroll(&priv->dw,
-						PCIE_ATU_REGION_INDEX0,
-						PCIE_ATU_TYPE_MEM,
-						priv->dw.mem.phys_start,
-						priv->dw.mem.bus_start,
-						priv->dw.mem.size);
+	ret = pcie_dw_prog_outbound_atu_unroll(&priv->dw,
+					       PCIE_ATU_REGION_INDEX0,
+					       PCIE_ATU_TYPE_MEM,
+					       priv->dw.mem.phys_start,
+					       priv->dw.mem.bus_start,
+					       priv->dw.mem.size);
+	if (ret)
+		return ret;
+
+	/* Size the inbound window from "dma-ranges" so PCIe endpoints can DMA to host memory */
+	ret = dev_get_dma_range(dev, &cpu_addr, &bus_addr, &size);
+	if (ret) {
+		dev_warn(dev, "no dma-ranges found, assuming identity map over 4GB\n");
+		cpu_addr = 0;
+		bus_addr = 0;
+		size = SZ_4G;
+	}
+
+	ret = pcie_dw_prog_inbound_atu_unroll(&priv->dw,
+					      PCIE_ATU_REGION_INDEX0,
+					      PCIE_ATU_TYPE_MEM,
+					      bus_addr, cpu_addr, size);
+	if (ret)
+		dev_warn(dev, "failed to configure inbound iATU (%d)\n", ret);
+
+	return 0;
 }
 
 static const struct dm_pci_ops qcom_pcie_ops = {
-- 
2.55.0

