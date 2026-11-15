Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A5606A332
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wmyml951;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GUaOALJ4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AdJ2aQEO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B95B80F56;
	Sun, 15 Nov 2026 19:00:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ebXyqJtLx1r; Sun, 15 Nov 2026 19:00:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1404080F58
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769252;
	b=kgV0N3Aau3O+pbDJ023clLQXljaH9R4ERP0qIax6Y0YKCMAGLqot6a5ajhpxqhK0LbVI
	 9ISO1RcOzNEeBRm+Y/765MAkRFxObSTjg+oblxH9Jp87tdhP8MujNbtBWkulb753sZmvx
	 lnoOzxc0ynVpO64Dc4MqhgpiKbf9ZYqeKcgEg114f0dKAwlZXNqpcYTEuglUzb0L1Z4ij
	 ncbuR4ZQf0p/mVMiERnkxye8xCNTwSoKOkXgneeTaLHKTYzHLA14a80akgC7Gd4pXYYCb
	 GHTmGKVUNdtCIDtePov6RrYVVrl8149465Xthbgf21fK9FObByAu/zIqsvzsUS8veMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cxRlOjym3hq2PVwECF9oYnNl0RWmHNGTnqjpRWj2Cls=;
	b=IYJ6nf8EphOR9NzApC9ICSfNUWu/4IVjakvKPyUhH/WByodeS3jja2NYMUMDxbhMTWQy
	 kTs13r+jmg5un2uSS5qBo7ePGzidHG/pySmNCrd2XNsNLrnk5tblEryI9+I62KgITbi1F
	 DHsmlDEZrt0tMQ5cyonaeIasVnfbbVOKfUfQfGno40Ce92JDX5UeZxxN4lcKmdEIoLTBh
	 OqOeWWZmlbp1HiUzdgGW5NWr5oU8Bml99zWHkwF7Qcq5wXPIEt7+/XQsxunr94/UrhAOB
	 +r75b8Rt1xoKYGplA8BT0AL/trIDyr8fUDk9QHaEzoLKcSjEJMRkuHgqySU8KAItAMw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GUaOALJ4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AdJ2aQEO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769252;
	bh=cxRlOjym3hq2PVwECF9oYnNl0RWmHNGTnqjpRWj2Cls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wmyml9518XX0e7vnQYjDWrBfDjqzUPEHOUVVmbQrUSe3ymhJLB5MnpIrlJwyq5jDR
	 5A3k2BaBGcyrZS8lMXh0eaH2rWpH0NjKQuDQuI6cQvQr475SyvKbiR/5ou3SG08CkZ
	 IT9wOLbdoV+enugc+I7C+bAnTmERvrs0+1BODAcFFQRc5kw+8/h2oYWctCYs/oY0Ca
	 HCDBlqG7THeNPEhA7j24Y2fRrQBc7XwG/VjU4AkBvhBQbu5MR0ddIhp7esGTXSyXZp
	 Zc8ybaMV28WXHPsUb/GVYaEOblSTC0v3ILXyf4Pl4pCpYpUWMyC1DI7ytajPXOkQt1
	 Gb/l2jTYkiOIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1404080F58;
	Sun, 15 Nov 2026 19:00:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E01070B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19C7380E86
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7xpbz5f5bDgO for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:20:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C4E980E9C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GUaOALJ4; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AdJ2aQEO
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C4E980E9C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFFCA9o3023018
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cxRlOjym3hq
 2PVwECF9oYnNl0RWmHNGTnqjpRWj2Cls=; b=GUaOALJ4s4+MUYKoaVinc+R/vcq
 VqjAdB97XJxcocBN2zZ2tI/ZNPOaTegwGUwBTG/x3ZZuc6k7eufs3TmEtgxk3nCe
 hVXx2ZFPAP/k9xwkn6lsDTwhONylyFMCjf9EdNDL4KOmPKxGFlyp1Yei++PZ8iDG
 t1/mdIIRiQC+Jr+D5ynB/yqq9d5E57SmPg4DfZtZHKK6nhrVhB6yl+vdWWRgr4fo
 vMCRVr5odzPmf/2Ghyc9WHT5pdo7HHwTPTOCJYxRdALpj63KI3hvRZzbDGrFnnid
 pA6VTZryil3RG1q2rKTuUmgVnN8/uOYcOVQr11bBMVYO2dbFpMV2WsWo9Jw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjume8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-375bac6bd21so2186426eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794766827; x=1795371627;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cxRlOjym3hq2PVwECF9oYnNl0RWmHNGTnqjpRWj2Cls=;
 b=AdJ2aQEOvV1gfIPvC02dY4wiSOlmstd+rCkm2fVOwQE6ZgpoJZQIDBDx5/9uASm9Gi
 AJDgAgfyvntfO/q8Fr8q1zC11KZetYmYkFU1gH/QUojujwwiuVkVrtzU9CF6LhjBEShJ
 mixpE0QEACINisPGT3JEFr6v+QMBFmeFTSNliFkkViWuCPiJAp0NK7TwYqSzkfG/+Qh/
 Qag0uEgTJs9b5fcJ8ckZR6clzQ7jW9bWhsoQ/PeSrz5M5OY7QK7tgesz6aRk3qXIn3s/
 4ajooX0ghpzWVB5c8YdsbtCCAc/w6WYqZuHMbGTPIWqqAS5pIZUB6o1rnQ/cKDWr+7C8
 G+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794766827; x=1795371627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cxRlOjym3hq2PVwECF9oYnNl0RWmHNGTnqjpRWj2Cls=;
 b=Wv5jmLBKi7KcOeP8r7n5vsW7TjopWSzKrF6QkOlNTpg82yDdrrDzKWFLnLhWn1w66b
 3hATVqswHg1WH+8EzvPRdjdEwdNKW9llAP/bgjO6HE6knKt2jmYyZusRfQAIeKyQfPjk
 LDSBzcYIpGVGsc3Xq2rCfGLefLCdE5wfIjT7E6PeRjRaHjNFZD/KtmulwT8v3cEEo5Tp
 w1adY3geJuHN2GwEBxcPawEtj1voj1V0FGUQfIcUyoRdUZyhXBYoqQJBjxoIUuedMOyl
 sx2uhz5d5medCfIxk0iimvm8awRxkFtND5QmDKlyinJc0jMDluDTonsTZE4q+V5iqnMa
 9SYg==
X-Forwarded-Encrypted: i=1;
 AL+hErHcI8ioWzFa+TMGhWOvZ9nqHFLMbFzJHUtV48mMOtKDdxB174yaFe13ixRJxLOmN2by9s++9xk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ffDWjy434YkwXhsl4BfeLDJ2qi5TcYMbVKf51i6WcgcVHwpBL
 cFUdMXdijFWGUDceRq4q7iQjs8m2FkNt1CMJoYvdowtnn9J49iL5YGE88NYID4xberoggEYH3th
 zBGFQpZ2WWLxDsb4GOrsABB6h3UmbHdodUeknzP1dv9p3rD7eliMP7bUbhiex7uyjCBPRZRQ=
X-Gm-Gg: AYBFou2SmCoT5/DkG3kRDXRHL2lUwlyPAT6dKTICXs/NF6MhDwIZ8HG6jK3W3fC6euH
 ikLkiaXJNIuBydrEKBjP32BPauufdTL8v+IZ7dLpmEIFg+IoAxytvK4q5N8uhKD2p34FON259/G
 HlWfN3CPc6EcK9eDZruE2dCmHLE1FAe7c8DAhvw8k07WlzLM6KIINtsodQCVOBbJZQE5yiqP/Z6
 RICBci8T6qTMO+N0Z+9qbQKWmJZOVj0tfFZXP6uogaArfDGh5xcbprlUH1ME7L20CH3975tE5hr
 NCpdxnWAxxID6VxZceCQsQCUnohrwt+M9P0SITzT9hsTVOhTqyA1drXiMNPZSF7Jm7DouwaLHsd
 0bdRf+peP6gOqfDPJF1vKnk1Aagvc0GN3vVzsx9Hze30rpjiXeXds7XchMFBuep4df0FDV8vZzY
 um
X-Received: by 2002:a05:7301:1527:b0:36c:a26f:83c4 with SMTP id
 5a478bee46e88-377e101681cmr10930534eec.13.1794766826706; 
 Sun, 15 Nov 2026 10:20:26 -0800 (PST)
X-Received: by 2002:a05:7301:1527:b0:36c:a26f:83c4 with SMTP id
 5a478bee46e88-377e101681cmr10930506eec.13.1794766826084; 
 Sun, 15 Nov 2026 10:20:26 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm26598663eec.16.2026.11.15.10.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:20:25 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 macpaul.lin@mediatek.com, junhui.liu@pigmoral.tech,
 quentin.schulz@cherry.de, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH 4/6] net: dwc_eth_qos: qcom: add SA8775P support
Date: Sun, 15 Nov 2026 23:49:34 +0530
Message-Id: <20261115181936.1750625-5-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
References: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfX1s1vXRFpefOA
 SltqYNBh44Uc6NF1L28d39BEDbcBNWznvQFcEl6Cc/oaJG7ppklEIiK+BvegrGH1mdmkcne8SDs
 7pjYgPD6ZUdEF+unrSn9vnbiO51IDhEKzhpERdosD7hqzcRKkPXqYcSnWkF4zLAcEzOu3FQRWYd
 m3N1AFNuxGbr1yev/gttvdbHVYADrK6miGeLeI5dSaGt0JKxuLCDgnRuZCdzISm7jHRngvVkpT/
 WOr0MGU3CRjvDVILurDhk2GYo1Ri0ZfXnAoys1QkRxFImHUSPpNoTnU4nnlRB/s97gI+wDi8Vsu
 pD64dms9rurxW99W4wPPbf4Rk66IuSyEmcrAFa/e7NWbIntmBuza5za93hEVN9fgSuS4Q8ylkxP
 2JyF5PsO4qkBr2xB7B0ofa0Kpv3aOE2L3bQdqkTz+q4NGBmBN0UAeDJM2EPWd1SIQkJ0fghELxA
 WWpm2nSqnaKLGpiyl+w==
X-Proofpoint-ORIG-GUID: 3F73_FXNCCzmpuwLc0P-xf8KbRsJ6kdN
X-Proofpoint-GUID: 3F73_FXNCCzmpuwLc0P-xf8KbRsJ6kdN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfX6h3qTIWih/vk
 Z+QC8Czaz9ohUEWmhwY8Bhwqkd3FQuG2y7xzwMhARn3oPMi19UEENdOjc7vht+fBJVhK5wB28ZV
 x64exHOB0HY6/06ffwoD2PenwroQFsU=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af9f7eb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=liYKozJyzQDiQMnR0lkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150072
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:41 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

SA8775P uses the Qualcomm EQOS wrapper with an external SGMII SerDes and
relocates the MTL and DMA channel register blocks to offsets 0x8000 and
0x8100 respectively.

Add SA8775P platform data and resource handling. Bring up the SerDes with
the Qualcomm clocks, use the wrapper loopback during initialization and
configure the MAC, wrapper divider, PCS in-band negotiation and SerDes
mode for 10, 100, 1000 and 2500 Mbps links.

Enable PCS in-band negotiation for SGMII and keep it disabled for
2500BASE-X operation.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
 drivers/net/dwc_eth_qos.c      |   4 +
 drivers/net/dwc_eth_qos.h      |   6 +
 drivers/net/dwc_eth_qos_qcom.c | 296 +++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index de06bb46151..0888c7f00fc 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1662,6 +1662,10 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "qcom,qcs404-ethqos",
 		.data = (ulong)&eqos_qcom_config
 	},
+	{
+		.compatible = "qcom,sa8775p-ethqos",
+		.data = (ulong)&eqos_sa8775p_config
+	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STARFIVE)
 	{
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index 51ab5469c28..3ccbe7a03c6 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -5,6 +5,7 @@
 
 #include <asm/gpio.h>
 #include <clk.h>
+#include <generic-phy.h>
 #include <linux/bitops.h>
 #include <phy_interface.h>
 #include <reset.h>
@@ -306,6 +307,10 @@ struct eqos_priv {
 	struct clk clk_tx;
 	struct clk clk_ck;
 	struct clk clk_slave_bus;
+	struct phy serdes_phy;
+	phy_interface_t serdes_interface;
+	bool serdes_inited;
+	bool serdes_powered;
 	struct mii_dev *mii;
 	struct phy_device *phy;
 	ofnode phy_of_node;
@@ -336,6 +341,7 @@ void *eqos_get_driver_data(struct udevice *dev);
 extern struct eqos_config eqos_imx_config;
 extern struct eqos_config eqos_rockchip_config;
 extern struct eqos_config eqos_qcom_config;
+extern struct eqos_config eqos_sa8775p_config;
 extern struct eqos_config eqos_stm32mp13_config;
 extern struct eqos_config eqos_stm32mp15_config;
 extern struct eqos_config eqos_stm32mp25_config;
diff --git a/drivers/net/dwc_eth_qos_qcom.c b/drivers/net/dwc_eth_qos_qcom.c
index de0ae090c5d..66ae8897ae8 100644
--- a/drivers/net/dwc_eth_qos_qcom.c
+++ b/drivers/net/dwc_eth_qos_qcom.c
@@ -11,9 +11,11 @@
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <generic-phy.h>
 #include <phy.h>
 #include <reset.h>
 #include <syscon.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
@@ -70,6 +72,23 @@
 #define RGMII_CONFIG2_DATA_DIVIDE_CLK_SEL	BIT(6)
 #define RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN	BIT(5)
 
+/* RGMII_IO_MACRO_CONFIG field used by SGMII (same register as above) */
+#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)
+#define SGMII_10M_RX_CLK_DVDR			0x31
+
+/* EMAC_WRAPPER_SGMII_PHY_CNTRL1, offset 0xf4 in the "rgmii" wrapper region */
+#define EMAC_WRAPPER_SGMII_PHY_CNTRL1		0xf4
+#define SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN	BIT(3)
+
+/* MAC_CTRL_REG bits -- same register as mac_regs->configuration */
+#define ETHQOS_MAC_CTRL_SPEED_MODE		EQOS_MAC_CONFIGURATION_FES
+#define ETHQOS_MAC_CTRL_PORT_SEL		EQOS_MAC_CONFIGURATION_PS
+
+/* DWMAC4 integrated PCS auto-negotiation control register */
+#define ETHQOS_MAC_PCS_AN_CTRL			0xe0
+#define ETHQOS_MAC_PCS_AN_RESTART		BIT(9)
+#define ETHQOS_MAC_PCS_AN_ENABLE		BIT(12)
+
 struct dwmac_rgmii_regs {
 	u32 io_macro_config;		/* 0x00 */
 	u32 sdcc_hc_dll_config;		/* 0x04 */
@@ -614,3 +633,280 @@ struct eqos_config __maybe_unused eqos_qcom_config = {
 	.interface = dev_read_phy_mode,
 	.ops = &eqos_qcom_ops
 };
+
+/*
+ * SA8775P (Lemans) SGMII/2500BASE-X profile.
+ *
+ * Unlike QCS404 (RGMII), SA8775P talks to its external PHY over
+ * SGMII/2500BASE-X. The MAC block itself still needs the "rgmii"-named
+ * wrapper register region (it carries SGMII-related bits too, not just
+ * RGMII ones), but there is no RGMII DLL calibration and no reset line in
+ * the devicetree, and speed changes are driven through MAC_CTRL_REG plus
+ * the SerDes PHY rather than through RGMII macro clock dividers.
+ */
+
+static void eqos_sgmii_set_loopback(struct dwmac_rgmii_regs *regs, bool enable)
+{
+	clrsetbits_le32((void *)regs + EMAC_WRAPPER_SGMII_PHY_CNTRL1,
+			SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN,
+			enable ? SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN : 0);
+}
+
+static void eqos_sgmii_set_inband_an(struct eqos_priv *eqos, bool enable)
+{
+	void __iomem *an_ctrl = (void __iomem *)eqos->mac_regs +
+			       ETHQOS_MAC_PCS_AN_CTRL;
+
+	if (enable)
+		setbits_le32(an_ctrl, ETHQOS_MAC_PCS_AN_ENABLE |
+			     ETHQOS_MAC_PCS_AN_RESTART);
+	else
+		clrbits_le32(an_ctrl, ETHQOS_MAC_PCS_AN_ENABLE |
+			     ETHQOS_MAC_PCS_AN_RESTART);
+}
+
+static int eqos_start_clks_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	int ret;
+
+	ret = eqos_start_clks_qcom(dev);
+	if (ret)
+		return ret;
+
+	eqos_sgmii_set_loopback(eqos->eqos_qcom_rgmii_regs, true);
+	ethqos_set_func_clk_en(eqos->eqos_qcom_rgmii_regs);
+
+	ret = generic_phy_init(&eqos->serdes_phy);
+	if (ret) {
+		pr_err("generic_phy_init(serdes) failed: %d\n", ret);
+		eqos_stop_clks_qcom(dev);
+		return ret;
+	}
+	eqos->serdes_inited = true;
+
+	ret = generic_phy_set_mode(&eqos->serdes_phy, PHY_MODE_ETHERNET,
+				   PHY_INTERFACE_MODE_SGMII);
+	if (ret) {
+		pr_err("generic_phy_set_mode(serdes) failed: %d\n", ret);
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+		eqos_stop_clks_qcom(dev);
+		return ret;
+	}
+	eqos->serdes_interface = PHY_INTERFACE_MODE_SGMII;
+
+	ret = generic_phy_power_on(&eqos->serdes_phy);
+	if (ret) {
+		pr_err("generic_phy_power_on(serdes) failed: %d\n", ret);
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+		eqos_stop_clks_qcom(dev);
+		return ret;
+	}
+	eqos->serdes_powered = true;
+
+	return 0;
+}
+
+static int eqos_stop_clks_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	if (eqos->serdes_powered) {
+		generic_phy_power_off(&eqos->serdes_phy);
+		eqos->serdes_powered = false;
+	}
+	if (eqos->serdes_inited) {
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+	}
+
+	return eqos_stop_clks_qcom(dev);
+}
+
+static int eqos_probe_resources_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	phy_interface_t interface;
+	int ret;
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		pr_err("eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
+	interface = eqos->config->interface(dev);
+	if (interface == PHY_INTERFACE_MODE_NA) {
+		pr_err("Invalid PHY interface\n");
+		return -EINVAL;
+	}
+
+	eqos->max_speed = dev_read_u32_default(dev, "max-speed", 0);
+	eqos->tx_fifo_sz = dev_read_u32_default(dev, "tx-fifo-depth", 0);
+	eqos->rx_fifo_sz = dev_read_u32_default(dev, "rx-fifo-depth", 0);
+
+	eqos->eqos_qcom_rgmii_regs = (void *)dev_read_addr_name(dev, "rgmii");
+	if ((fdt_addr_t)eqos->eqos_qcom_rgmii_regs == FDT_ADDR_T_NONE) {
+		pr_err("Invalid RGMII/wrapper address\n");
+		return -EINVAL;
+	}
+
+	ret = generic_phy_get_by_name(dev, "serdes", &eqos->serdes_phy);
+	if (ret) {
+		pr_err("generic_phy_get_by_name(serdes) failed: %d\n", ret);
+		return ret;
+	}
+
+	debug("%s: OK\n", __func__);
+	return 0;
+}
+
+static int eqos_remove_resources_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	if (eqos->serdes_powered) {
+		generic_phy_power_off(&eqos->serdes_phy);
+		eqos->serdes_powered = false;
+	}
+	if (eqos->serdes_inited) {
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+	}
+
+	debug("%s: OK\n", __func__);
+	return 0;
+}
+
+/*
+ * Configure MAC_CTRL_REG (mac_regs->configuration, PS/FES bits) plus the
+ * SGMII-side wrapper bits for the negotiated speed, and drive the SerDes
+ * PHY to match. Mirrors Linux's ethqos_configure_sgmii()/ethqos_fix_mac_speed().
+ *
+ * U-Boot does not have the Linux stmmac PCS framework, so the SA8775P glue
+ * controls the integrated DWMAC4 PCS AN register directly. SGMII enables
+ * in-band AN, while 2500BASE-X keeps it disabled.
+ */
+static int eqos_set_sgmii_speed_qcom(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct dwmac_rgmii_regs *rgmii_regs = eqos->eqos_qcom_rgmii_regs;
+	phy_interface_t interface = eqos->phy->interface;
+	int ret;
+
+	debug("%s(dev=%p): interface=%d speed=%d\n", __func__, dev,
+	      interface, eqos->phy->speed);
+
+	if (interface != PHY_INTERFACE_MODE_SGMII &&
+	    interface != PHY_INTERFACE_MODE_2500BASEX) {
+		pr_err("unsupported interface %d for speed %d\n",
+		       interface, eqos->phy->speed);
+		return -EINVAL;
+	}
+
+	eqos_sgmii_set_loopback(rgmii_regs, false);
+	eqos_sgmii_set_inband_an(eqos, false);
+
+	if (eqos->serdes_interface != interface) {
+		ret = generic_phy_set_mode(&eqos->serdes_phy, PHY_MODE_ETHERNET,
+					   interface);
+		if (ret) {
+			pr_err("generic_phy_set_mode(serdes) failed: %d\n", ret);
+			return ret;
+		}
+		eqos->serdes_interface = interface;
+	}
+
+	switch (eqos->phy->speed) {
+	case SPEED_2500:
+		if (interface != PHY_INTERFACE_MODE_2500BASEX)
+			return -EINVAL;
+		clrbits_le32(&eqos->mac_regs->configuration,
+			     ETHQOS_MAC_CTRL_PORT_SEL |
+			     ETHQOS_MAC_CTRL_SPEED_MODE);
+		setbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrbits_le32(&rgmii_regs->io_macro_config,
+			     RGMII_CONFIG_SGMII_CLK_DVDR);
+		break;
+	case SPEED_1000:
+		if (interface != PHY_INTERFACE_MODE_SGMII)
+			return -EINVAL;
+		clrbits_le32(&eqos->mac_regs->configuration,
+			     ETHQOS_MAC_CTRL_PORT_SEL |
+			     ETHQOS_MAC_CTRL_SPEED_MODE);
+		setbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrbits_le32(&rgmii_regs->io_macro_config,
+			     RGMII_CONFIG_SGMII_CLK_DVDR);
+		break;
+	case SPEED_100:
+		if (interface != PHY_INTERFACE_MODE_SGMII)
+			return -EINVAL;
+		setbits_le32(&eqos->mac_regs->configuration,
+			     ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE);
+		clrbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrbits_le32(&rgmii_regs->io_macro_config,
+			     RGMII_CONFIG_SGMII_CLK_DVDR);
+		break;
+	case SPEED_10:
+		if (interface != PHY_INTERFACE_MODE_SGMII)
+			return -EINVAL;
+		clrsetbits_le32(&eqos->mac_regs->configuration,
+				ETHQOS_MAC_CTRL_PORT_SEL |
+				ETHQOS_MAC_CTRL_SPEED_MODE,
+				ETHQOS_MAC_CTRL_PORT_SEL);
+		clrbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrsetbits_le32(&rgmii_regs->io_macro_config,
+				RGMII_CONFIG_SGMII_CLK_DVDR,
+				FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR,
+					   SGMII_10M_RX_CLK_DVDR));
+		break;
+	default:
+		pr_err("invalid speed %d\n", eqos->phy->speed);
+		return -EINVAL;
+	}
+
+	eqos_sgmii_set_inband_an(eqos,
+				 interface == PHY_INTERFACE_MODE_SGMII);
+
+	return 0;
+}
+
+static struct eqos_ops eqos_sa8775p_ops = {
+	.eqos_inval_desc = eqos_inval_desc_generic,
+	.eqos_flush_desc = eqos_flush_desc_generic,
+	.eqos_inval_buffer = eqos_inval_buffer_generic,
+	.eqos_flush_buffer = eqos_flush_buffer_generic,
+	.eqos_probe_resources = eqos_probe_resources_sa8775p,
+	.eqos_remove_resources = eqos_remove_resources_sa8775p,
+	.eqos_stop_resets = eqos_null_ops,
+	.eqos_start_resets = eqos_null_ops,
+	.eqos_stop_clks = eqos_stop_clks_sa8775p,
+	.eqos_start_clks = eqos_start_clks_sa8775p,
+	.eqos_calibrate_pads = eqos_null_ops,
+	.eqos_disable_calibration = eqos_null_ops,
+	.eqos_set_tx_clk_speed = eqos_set_sgmii_speed_qcom,
+	.eqos_get_enetaddr = eqos_null_ops,
+};
+
+struct eqos_config __maybe_unused eqos_sa8775p_config = {
+	.reg_access_always_ok = false,
+	.mdio_wait = 10,
+	.swr_wait = 50,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
+	.axi_bus_width = EQOS_AXI_WIDTH_64,
+	.dma_ch_regs_base = 0x8100,
+	.mtl_regs_base = 0x8000,
+	.interface = dev_read_phy_mode,
+	.ops = &eqos_sa8775p_ops
+};
-- 
2.34.1

