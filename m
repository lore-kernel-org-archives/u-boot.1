Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB039606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hCCB7HJs;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gghTQoCl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pal+4NS9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61C7281086;
	Fri,  6 Nov 2026 06:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RrRraRHoRU1x; Fri,  6 Nov 2026 06:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 334CA81083
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793945293;
	b=Y7j0GlfDx4NuHT3hjx8QcuMi7giU5U8uORqZsLQ4WiEDipcXg4B/ia99QtRCaSPuNVNE
	 NhfAQTLNoffQ4IBVk/Zs6slfu0H7fMwmJiqYwx9qdcUKPQPhHB5Yk7J6ckL1XKQxJw3MU
	 G4TOPbFsSbhjbgDlq68doIJYSeAKm+VGAgeyYzkTE6hrshWK0+er3xuaHIDwkUQpDIwa2
	 VsFrVR45MGj049tcwjiY8LweBUTZtjpvrZTudCRa2J4z38zkXP/d2m2OtUKwCBe3lsmp4
	 /AFpXjzC+fFgUcv3IjoQ+EKBa/+v7SLnCAzxzVga6vjA71pAAZWwp2X3AicrRWU+vpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793945293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=;
	b=ZnV6BdAjwAH/XR5nCd2xju85AT01fJw2asrtsdKNHWnX8Cxy+xpsqnux0O0mSvcSblEy
	 siCA9a/3z/AZcDBh3QBT4VlreUb5HUoY0Xxr9h1b3KXj2hm46kuJeD6LqGe7b4YML/d5e
	 /wpNYmK+s8S6050o1PpDEZdEe6fTduPoOl8V9/GVphK1bzEt/XFlQYhvnfeHkbaXWzNts
	 xY4NMy8pGCVozMymHeR6hWgmbDETHsWsIyZ8pAbA0zeJ1BbvK2QBB81cfmuckiL+G+OaV
	 ptFOhAKm0tENh/Gx1LKEsZ6mFPpRGNb5TZZ8jNqVaYkYJpt59KIwrLP9BZ1C7XvOudg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793945293;
	bh=sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hCCB7HJshrFqEEultO49Dz/gPsnDOi8KJuDGcPKT7FfHXWrtpSIwzadB/OPoj8Nr5
	 r9JT7EFen66XAbaMBBjX2knylKurt2fOxKCWa5bpLCk1yzd8rBcafeO43w8w0iCd4G
	 kh5xKF1wU+1xwE71fC17QPEui7vmwsf4mRhCTeIKUBFO6tY2smqaD/dOWqYG7roLGM
	 /wUgCaWaEVK1s1WI+LL62MS9BxZSsfoZZY2OMzpudGci6Yu9h8mLgX+PNp4JSd3Nb/
	 UQlB5IPWdo9R+aFQTZVsD4iWEKZUtOKJ46GXbgfyEpo2D1f5EaH4TLB3dQ4NNabV9b
	 Oiwj/cDBbBD9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 334CA81083;
	Fri,  6 Nov 2026 06:08:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E55582FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D523E60657
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ASDH5yl_ngWh for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:08:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C8F8606E8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=gghTQoCl; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Pal+4NS9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C8F8606E8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:10 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A63xq5s1866572
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 06:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=; b=gghTQoClwQJRr7z/
 SxUkj2cbTkilLD4GAq/fCQmEf9aCkVflLy1p17Xt/gIsQxfZBFAKAYSQpKbj+sYs
 AtQVoj2nW6H/qQQ7Vu1jhl9tgtJZTTeaFUkPBaOM5Z8uTNSmWI2lcydhxDlsuqNz
 PoqjGCa/OSqI+DLkKCsacAMmrZhwx1/3wBSxCGBTswi9tVHzn2fkYFh4MwEt4Oc9
 h5o9yY3XsNcwjKO3cca8YlpZ624CRHFbV2O/nope/zg5n5kz1thxd/S27qti58CC
 aX7AlhzAEbyhLgICifKTmxTh5kROjEVnbKpplWa7K6NwrDBPWbH1eMOubxyKHMSM
 dc3LnA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p997a3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 06:08:10 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so1438758c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 22:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793945290; x=1794550090;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=;
 b=Pal+4NS9RtiezJvXu5vZFJLB6vijDXsChwe1L5bppPnRy4Jjrf5U3UwseX33evBHFT
 +/1+AhUQd9tmV1tQepjrrf6h5r9TeZZnRwkIWa/8+hS9I6SMC9CedhjUbCiZ4HwBvxMC
 T2rhyp4cQrb+cSf1HRMvzHhpsQw4XdGWg79PMcnM8NU0nEpXPGNgVq0sxXtkgoS6X+D/
 SvmE9o/xtY8fe26h+eEA4knefIHNbWuDtYw6tJlS5PZNoCZzkkKXQwgwrAxrU1UJqiK+
 y6ZKwxjAFzLb9lASfUOXf3LFg8oBN7ETUu4Nn0oyrF1Asq47HBxCwEigtGLg+iPjY45r
 Jp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793945290; x=1794550090;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=;
 b=uEl8Uv1ciKxzKeqr4Nyt02LEk+Q+TrbtBJcDS+VI7d+7Eo9Uj3nrfYztzbo02hUPry
 jqs7Z2BYbV+Srtx1Y7bQ4/6sf+dKAIuVqSfRie1k4Qf90OWfO5/55vM6FAhTZ8a8aePY
 80sWL6OuZ5jBenmnmksUI8MxM2brxH4795tI5fs+g5PurM/fcgWKWJJRl517gaUe2/TD
 PfuS1nB9CfMY1s5Nse9CibP/2enyiTtwnQlFj6uPmbBmSfywEZpA14zozIcCr+UnxPWl
 WTUP0eXDUEp1eB8RfxtPVjDlTN2B8jIS0dBK/Gw8/CutXhdQNDD2dwlSWwfmB+T6alme
 9yzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5DbUGB1aMMRLvqZJWVqklnsrsdCvoR2samvwBr7S40+lCVe4BwyBE8iaROWUMQR/EFejH0HM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9qAxvfYTA9QAlQ1pu9TMbbKxeBa32u1eMZr4z1CUjyzM9G9tgx
 4eF/Fxf3aDqxeY4PsPWXksO4b4Lea1MFmWwBsoFS4S0EZvG+4BiprOXSC1byqJqse+WDWzl/5Yk
 oKRLig3AFYhLh1UVyZbvsSDcG481JXKWA2ORhNkGSqsweA9O5osGVBoYxiza/p0LV+FCae4Y=
X-Gm-Gg: AYBFou38+dtoyK0412RbxccFlduTiS2lAQGJTnWZZdEk2DZTrMRXRDDBqDg+8DpTxwU
 8kkMaExGF7mzM1MCTtJdWIdqvSje/zTH/iWbl2l5xVJcNUAl5tmF6tC+w28UVz3H9+XT6hsc7FM
 wfGM9yIgPrsM1JasdQhPRkNiK00h2ynHkQv04nwpEj7wbhBfFD60PVHzRQNAK1N0rPuA7dKQruy
 lwfRMsoXZnYhjZH/U09UL4/vfWp91xui7Fd7Gw8jtaDcLbr5RZC0J/SrMMfq5TzBFWpl8CRHa0/
 ZI9DLkriCtD3uItLT/5Z8AF42k1BfYD1B2h0hFJfLgKXc+tyYiLyEZIrZkpOquzYvrtV5s4xneT
 eqVy9iUvAqo67Fa86Z9nSSgzA4vPerMa/4uejwwU84P0v6pW3YXccbYSw19lapIGQh0Ox3t5D2S
 TADf/yMsdYciv3yg925hd/adCDAWZt9h2gZDwtzcleJysFhggjiZkr/jVgSdMUrnmm2ABvwzqxB
 ohf2Fg=
X-Received: by 2002:a05:7022:3f0e:b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1b25d334fb2mr1903133c88.27.1793945289295; 
 Thu, 05 Nov 2026 22:08:09 -0800 (PST)
X-Received: by 2002:a05:7022:3f0e:b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1b25d334fb2mr1903109c88.27.1793945288808; 
 Thu, 05 Nov 2026 22:08:08 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4a610fsm2341373c88.11.2026.11.05.22.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 22:08:08 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 11:37:44 +0530
Subject: [PATCH v4 3/4] tools: qcom: mkmbn: Add support for ipq5210
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ipq5210-v4-3-5af12cc2b601@oss.qualcomm.com>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
In-Reply-To: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: bFngZuUb22gMr6Z6Qmgjxx4Ap4R_4PvG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX2Ne0LYyHWy/O
 CDwMKr5LSMgaMG4O5rXUF4/Z4Jx5ngIz31TtOG97uUOCG3Wx+Pvi/e9BB5dmEHyAKvJvcgb2Hoe
 4AfkRJS2RJ5u2kgfUoln57g5+Xhjm0S/03MGKzlrPwhBRgBnRvn4YCK2VK/EUr8bmXiSwhdDNc8
 DJDQCAE6pGlw2ZPCn1foMU4O2or8E6ARBqPnEooBqH/lS8rqbrTNZHsM8njQ6xgaVXn7wIrwV/h
 olhyXFHE1qntur6v9W4b8RXX8BdHJvXGT/S5AQ0ol5RW1/iSXqdWUQ45Qp16+VWXkTjQnY1DxKJ
 jTVXIYUwLbEH1Z3JGIlbM1G7qZ3ohrUGiUAXUnjhzu8sAf2zP4NfULAlGz8DXhq+rgU90MKhunP
 uSK8D4EKvZHa721FpwcJizObqGzdaGO0Dv+XXkq6qIiS39j4PdkSMBnvsCbU5e8ZzS7Pbkuet0x
 n3ozs9D39fkQrbuxBfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX4IBMAtwxCtZ6
 ITXttGkztmqWLeJpGd4xtJVvnSsXVqdRmsOP/CrvgIn5+Q8k/NSF5mnYqI/eCinXU3yXAz8BMs0
 iRrdZCSDYpkCH4+JqOoqW3Q5f2G/L4c=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aed6eca cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yH3UP6-NtsxmdlPH3hAA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: bFngZuUb22gMr6Z6Qmgjxx4Ap4R_4PvG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060024
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

- Add ipq5210 entry to the 'boards' table
- Add an argument to specify the U-Boot Proper/SPL load address and
  drop it from MbnData
- ipq5210's boot rom expects the SPL image size to be 4-byte aligned.
  Enable the mkmbn script to pad the image to 4K.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 board/qualcomm/config.mk  |  2 +-
 tools/qcom/mkmbn/mkmbn.py | 63 ++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..1752b651402 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -8,7 +8,7 @@
 # Create Qualcomm signed elf images
 CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
 quiet_cmd_mkmbn = MBN     $@
-      cmd_mkmbn = $(CMD_MKMBN) $<
+      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_$(PHASE_)TEXT_BASE) $<
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index 8d2078acc30..da4d45b600a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -18,6 +18,8 @@ import sys
 from enum import Enum
 import struct
 
+MBN_ALIGN_SIZE = 4096
+
 verbose = False
 
 def log(*args, **kwargs):
@@ -56,42 +58,40 @@ class SwId(Enum):
 class MbnData:
 
     # sw_id 0x9 is aboot/uefi, the most common
-    def __init__(self, loadaddr: int, version: int, sw_id: SwId = SwId.aboot):
-        self.loadaddr = loadaddr
+    def __init__(self, version: int, sw_id: SwId = SwId.aboot):
         self.version = version
         self.sw_id = sw_id
 
 
 """
-This dictionary is used to map a board or platform to the appropriate load address and
-other MBN metadata. When adding support for a new platform to U-Boot, the appropriate
-data should be filled out here. The load address can typically be determined by looking
-at the uefi.elf or xbl.elf for the platform. For the uefi.elf it is the load address, and
-for xbl.elf it is typically the RWX section in the middle, just BEFORE the section loaded
-at 0x1495xxxx or similar. Looking at similar platforms in the table below may help.
+This dictionary is used to map a board or platform to the appropriate MBN
+metadata. When adding support for a new platform to U-Boot, the appropriate data
+should be filled out here. Looking at similar platforms in the table below may
+help.
 """
 boards: dict[bytes, MbnData] = {
     # Exact matches for boards, these are preferred
-    b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.uefi),
-    b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,qcs6490-rb3gen2\0": MbnData(6, SwId.uefi),
+    b"qcom,qcs9100-ride-r3\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs615-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
     # Fallback/generic matches since most boards for a platform will
     # use the same load address
-    b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
-    b"qcom,qcs9100\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
-    b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
-    b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+    b"qcom,qcm6490\0": MbnData(6, SwId.uefi),  # rb3gen2, rubikpi3
+    b"qcom,qcs9100\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8650\0": MbnData(7, SwId.uefi),  # SM8650
+    b"qcom,qcs615\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,ipq5210\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq9574\0": MbnData(6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same
     # They use header version 3.
-    b"qcom,apq8016\0": MbnData(0x8f600000, 3, SwId.aboot),
-    b"qcom,msm8916\0": MbnData(0x8f600000, 3, SwId.aboot),
+    b"qcom,apq8016\0": MbnData(3, SwId.aboot),
+    b"qcom,msm8916\0": MbnData(3, SwId.aboot),
 }
 
 parser = argparse.ArgumentParser(
@@ -100,6 +100,9 @@ parser = argparse.ArgumentParser(
 """
 )
 parser.register("type", "hex", lambda s: int(s, 16))
+parser.add_argument(
+    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
+)
 parser.add_argument(
     "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
 )
@@ -149,10 +152,18 @@ if not mbn:
     args.output.unlink(missing_ok=True)
     exit(1)
 
-log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
+if args.load == 0:
+    error(
+        "Cannot proceed without load address.\n"
+        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
+    exit(1)
 
-elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
-elf.ehdr.e_entry = mbn.loadaddr
+log(f"Detected board {match.decode('UTF-8')} with load address {args.load:#x}")
+
+data += b'\x00' * (-len(data) % MBN_ALIGN_SIZE)
+
+elf.phdrs.append(Phdr.from_bin(data, args.load))
+elf.ehdr.e_entry = args.load
 elf.update()
 
 # QLI boards use v6 sw_id is "aboot"

-- 
2.34.1

