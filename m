Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF9606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZkvWwUJX;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MgQqRuTH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jNMX44Ka
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C342540ED4;
	Sat, 14 Nov 2026 04:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n-_2ginl70sv; Sat, 14 Nov 2026 04:06:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F416940DEC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629186;
	b=qZDyuOQ95KAqOMIICkOUvh0E89V+4Y9WYQcWraZCzhCJogsMjlgupY8jkds6gLStHgbg
	 MWBGuC1wNjsI2NAGmMWH8TeIVJyJv3bn10wjN6WeWIgvhxH7G/vDp3Lvvwki+t7kbeZv3
	 WKyk94xuvAK1UN7dpP3j44I9Y3c6IP5raUPbvzS+LGtBV2QaHJhbVxIb1QeJw1s4wkuVg
	 344z21WQMrmaAKzwQWFYZn7BL0i+1GC22PPUejgqgLo/zid2YPzh4dEr3Xyjo0GU1Z0sG
	 mX8WKQrDkPqAIhC/0pcnIYJboBHjuXQc9qN5LS7unjTMnNQaOL5bP7fu2DtIDTpKyNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629186;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4JgZwEsv7buD1sT6DcPhA33gJxlqtwgHSgYX9p0DUKI=;
	b=Pho/+sGIHmZG636uB1fWJAltBYwrI2ZBKdbNIIOXDG6CGONF0ut89wd1tO3mB/14j5hi
	 tUrDIG4KnDCEgPMcAtWuv4nnb+XxZVsMNNdCPyfFduVUftpuZTcrG0H5jp5P6tQGiSWux
	 x/4lL9YwmJp2hNAvvWWG4FO1aN3+aaY8fDsdZU5/u17vhv3YB3b7bdAULud3ZnAiuMauI
	 KFILND2AyWobA45oAFAVHaYyI50IX2e6C7vZ21eGNzodhtivj0kobrTueZVkogVug1Y45
	 c0VSnmGNHU4soHTz5iURy8DN4CEtDGdRqEphIB+VpNQ5CpMIhwk6kix4n1Df5uPcINg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629186;
	bh=4JgZwEsv7buD1sT6DcPhA33gJxlqtwgHSgYX9p0DUKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZkvWwUJXicMwhhcTCe66epm+lDEGY3IYHIYECzagC2aaATLEuwi8uFM4IyLWLLYkj
	 CN8SY15+pkkG2lsbOUNXmVM/KFScGFdiTPSW2zPm87KPmECgyQIGPNV4oQvDcuOnG4
	 5Oqg1GPTBHrW8iW2doNFse08X4xe/xIsNzsR7EyLRiJQvCAVgm624sxsi8bKfqMfcX
	 iIdu+UVeH8yiMQ1So5/UkZCzsArX5I+0ytsbqrrVMOOF9jKYofGkheyXSzcD98q1E4
	 23rJF71IbXQIKNb/phOg9MB+KxnxmX3T6IL9St6STNmKggqeLs2P3buSFMXvWwo6MA
	 oucdVFvPKbR4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F416940DEC;
	Sat, 14 Nov 2026 04:06:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF5E92FB
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E07A481858
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sF234ktz0wb1 for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 04:06:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D9D04811D5
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=urvashi.sharma@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=MgQqRuTH; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jNMX44Ka
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9D04811D5
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF7E3847FF; Sat, 14 Nov 2026 05:06:18 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1957E847FF
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 05:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=urvashi.sharma@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AE29PvA2844914
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 04:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4JgZwEsv7bu
 D1sT6DcPhA33gJxlqtwgHSgYX9p0DUKI=; b=MgQqRuTHD3mOfh41dkReDjdFx2y
 /aeDpDpiwZBA/p6ljuaLTZKsFL1FmQWWaOZ7C5KgJyn0dswEQVVA/qvosSrpa00q
 vEmBNrIs4XxLO+c2s98o8h/p9BoguByuGigWAIeBPJmUjoIZ2X2xg8JXbRx4CAfR
 mU0Rq7ahPbmqS+dE5cqQQZ+oHOzPy6XwOeUW5BNg28bYu0pNnz2V2SdnwLEsdbkU
 rdwzCqCCPLygF8eAiHdGMzO6g1oVrGCRAoZT7Rr5aYZlviDRamnYOeecFux+Npxj
 PNnZzkKtSo0l9dZwPhLI+kQuxApLzRNoTf0uallZ1VtKgGjCRyoDiWXby0A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxekr87xw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 04:06:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-37549877380so2104203eec.0
 for <u-boot@lists.denx.de>; Fri, 13 Nov 2026 20:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794629163; x=1795233963; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4JgZwEsv7buD1sT6DcPhA33gJxlqtwgHSgYX9p0DUKI=;
 b=jNMX44KaXzmms6SrPRZOYOX0BzMJ8FNjhs98fBnzgKy7FfyKNlKocCMi9zZq/uM7fu
 jp7T7FKKab5bn7D/Ay+gAER0rW9MMy6oSPHzFtdmwXqR0nkiEgpl8RVhaBPznJg0ufeH
 9xnIDky3r6/o3zYW6FXgJTvd36Du2awYZaJYjvjTwat8W6p8T7kwJxnsECXqWzHLpG64
 nNRaOZmMBUo9zXix7aumBaSPIOc5YheOwbkvOI3qxq2QQ2o5ulJWLUfej0zk/BGCv7Dj
 XPy++97Uy1TN0TIzBStGiy6UzFty8UadsnoyGWRc1glx7dewZuaxnmwyR+vT2ip4rmEv
 9hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794629163; x=1795233963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4JgZwEsv7buD1sT6DcPhA33gJxlqtwgHSgYX9p0DUKI=;
 b=zj3/FPCOWWRuuojnq+FeV+URJgQ9UbdWBSn6gIDHvjR8Lfdup6z+XEZa5SuDkiFs6k
 AVAFfRQbU83NCiClY/4kig3zz6EFTymqyjylczMhGKdT2SjD9CVMIzAwO4KAJBhLevNZ
 iXvpP/sdcFZV8jVZKgRwrXy56MiTgbfLycSeN8y4mEU0tLbPhpphm3Z6XRfFhN/gCLaA
 3y5raQalgkhDLi3rC1cXaxkgCOMWlKdP1gMpScAHzQgGnCAgZkXCrqaIEu82fWvJmKCX
 aTROlwh/8oWsTb8ui/Sqr+AkzBnlJP6/i1xPxpNmklVUU5n2R7ZozVh29PRTZeEp4ryW
 nk2A==
X-Gm-Message-State: APuU4Z/Juw4vuJZ5pyv5GOlq+kxWxkxFSeT9wrkeyRdU2estkmbRnykX
 N3UFaQVdS+yht2Tk+fTBnVFgalnc9GTh0WXZd5dXXw23cld2ETtZTXqXKunZjFkiJV+uYQkk9Cy
 XRlHwoVWsUPnvVMrvUHw/jAmfUD+aBqIDpGxhP1ImpOEDVkIQrY4k23IBhPQ+VxbK
X-Gm-Gg: AYBFou2+ukD5m6sOMrU8b1LJ7De/orQiVtPwf/rkVXx7tvkIjL0youUpZlFrvmjwDna
 1YZiioNP52zeXZDORn9x29Jao2Wnf1ZCefnqf5r1L+A2yGFFHE1rUZuthDqN0voEt8yyTjmE0wP
 Pfd4Cx5i/FpnNmHgKh6+ApPGq0IP0sn5Sf54bNzIlpysr6Y1YvdLOYpaKkIDe0wiRQjzzHHENTn
 MAlHoV4moFnS8gQ/W27QG27/UowXnJbc6Wqg4Y1EMnzQmEbcjMQTpmAhGhtEtDZCPZ/KpRO+UfA
 XCFeDJhkM5ZFU1eVYMxVqMsJsGdIimfdMLcnI5HEXIXjhLA/JBUQKMRjf6jSyjpuARXN9T+kMRO
 GPxK5UGvXz3Wvt86Zgrsiz0RxcfkzvL/pYGMUx42SQOK/nukz7RDKvD3MgmTFzNxKi1KIfze/zJ
 qjC4ZzRJC+2slIajUMhGEIGDgc3IIVmw==
X-Received: by 2002:a05:7300:72cc:b0:372:598d:c0bb with SMTP id
 5a478bee46e88-37966e3ad18mr6006446eec.13.1794629163067; 
 Fri, 13 Nov 2026 20:06:03 -0800 (PST)
X-Received: by 2002:a05:7300:72cc:b0:372:598d:c0bb with SMTP id
 5a478bee46e88-37966e3ad18mr6006378eec.13.1794629162115; 
 Fri, 13 Nov 2026 20:06:02 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm11536621eec.16.2026.11.13.20.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 20:06:01 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org,
 trini@konsulko.com, digant.shah@oss.qualcomm.com
Subject: [RFC PATCH 0/3] blk/scsi/ufs: scatter-gather read support
Date: Fri, 13 Nov 2026 20:05:52 -0800
Message-Id: <cover.1794628845.git.urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ptmm7jaltdwuyxj5ks26oht2cj6ckp4at6prvra27l4r6idkiz@xzyj2s3spx25>
References: <ptmm7jaltdwuyxj5ks26oht2cj6ckp4at6prvra27l4r6idkiz@xzyj2s3spx25>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AM7YGcXKgO0VILdoY-7MWmzgZ74rf8gN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxNiBTYWx0ZWRfX3V+vRxOisR70
 rD1cLM5YHBxxZ3o5y/+SHwH4BQd0sH0NRSkSZMCak9H8HZjb3pn/5tgtG+0nYvV4Q+8X3FGSQDt
 SrQE1M3nL4rtBKZ9iv0khNGMkKjUmER5KpZpw68NKOzd++s+SXf+S2vJQRWmcwWcwglLwYoNF7i
 ZPwvdlQVVqkqYcCB6CqhAEUGMncYaAKBQAXuDhZMT+ZY6vVnkprYtJVkRh1ZNIHlHsuGzoyWHb4
 Z869wVcY4th+COLSlwtYymVBrpyiVRifGDAMOMtDfnwo89Q+0+Kv3be1XD24Yip1Lo9u7uYvjl0
 J48Jn9uMXgxBe1LgvgeaJ5VpzMQvAU/RAvX7ZnbFitqx+O6h/1iHO6grek9zgytZEqV1lEQhK5F
 lxOwkhpf4N9XgHkcXTcZuM+ULyslenkdgoYiSjLKKnow1a5NhU2eCzIS2Hwml4HEIktFiknk0m8
 Pv0jSVooy67TtEr+/cQ==
X-Proofpoint-GUID: AM7YGcXKgO0VILdoY-7MWmzgZ74rf8gN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxNiBTYWx0ZWRfXwLmFUcj6yYre
 TsE5Y6nfL1rwiBLEJJ1EfUwDn1c6Ff/akMpuXcr7PMQJ+5/N4FCvKCjpb2k1CSjXPydIXWVEFno
 pmAFLVz1SXh7WJoTO/jNQX1vHhGnFeI=
X-Authority-Analysis: v=2.4 cv=AfAkjHXG c=1 sm=1 tr=0 ts=6af7de2b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=otcy3WQqAeomPnPpcn4A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140016
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This implements the scatter-gather read design discussed in [1].

Reading one contiguous block range into several separate buffers
currently takes one read request per buffer, since the block uclass
has no way to pass a list of destination addresses to a driver.
Controllers which accept such a list for a single command, like UFS
with its PRDT, cannot make use of it.

Patch 1 adds the block layer side: an optional read_sg() operation
taking a struct blk_sg_list, and blk_read_sg() to drive it.
blk_read_sg() checks that every entry is a non-zero multiple of the
block size and that the lengths add up to the requested block count,
then either calls the driver or loops blk_read() over the list, so
callers behave the same way regardless of the driver. Patches 2 and 3
implement read_sg() for SCSI and UFS.

Changes from the design posted in [1]:

- addr in struct blk_sg_entry is void * rather than unsigned int,
  and entries carry a byte length rather than a block count.

- The list is still a struct rather than a bare count argument, to
  leave room for flags or alignment hints without changing the
  read_sg() signature or its callers.

- Names are prefixed blk_sg_ / read_sg to keep the storage sense of
  scatter-gather distinct from the DMA one.

- blk_read_sg() falls back to one blk_read() per buffer when the
  driver has no read_sg(), or rejects a list with -ENOSYS or
  -EOPNOTSUPP, instead of returning -ENOSYS to the caller.

- Kconfig symbols are BLK_SCATTER_GATHER_READ and
  UFS_SCATTER_GATHER, as the generic part belongs to the block layer
  rather than SCSI.

There is no in-tree user yet, so both symbols default to off and no
defconfig selects them.

Tested on qemu_arm64 with QEMU's UFS device, reading a block range
into several buffers with blk_read_sg() via UFS_PCI.

[1] https://lore.kernel.org/u-boot/ptmm7jaltdwuyxj5ks26oht2cj6ckp4at6prvra27l4r6idkiz@xzyj2s3spx25/

Urvashi Sharma (3):
  blk: add scatter-gather read support
  scsi: add scatter-gather read support
  ufs: add scatter-gather read support

 drivers/block/Kconfig      | 10 +++++
 drivers/block/blk-uclass.c | 75 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi.c        | 58 +++++++++++++++++++++++++++++
 drivers/ufs/Kconfig        |  8 ++++
 drivers/ufs/ufs-uclass.c   | 75 ++++++++++++++++++++++++++++++++++++--
 include/blk.h              | 61 +++++++++++++++++++++++++++++++
 include/scsi.h             |  6 +++
 7 files changed, 290 insertions(+), 3 deletions(-)

-- 
2.34.1

