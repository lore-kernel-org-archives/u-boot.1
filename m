Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC731606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xnd44RnG;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPIMxFXB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kvcskDBs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C851C810FB;
	Tue, 20 Oct 2026 10:22:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D3ekEThnqQhI; Tue, 20 Oct 2026 10:22:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2015A810E2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491756;
	b=NdpBJdnKVhfK8jP1MEdC2ha0CAHXeM1gXO1fdhM1ZEklWxXl8T5oalQYIG7MZ5uZQYYy
	 w9vHBx5LNhIhmvN6K1F6M1oLSPFIIdOpzj2GxvQ/PVfZTA1I0zwdKwnQhPsw+wbwqNWvS
	 ONn3mzzZso0nJ8ra5E+UhPy8qAI3ip3EP7vvgnCq4Zqa9mwipTsYiScXh8jKbttQfyeQB
	 w0TdEDCps46V8/aHlf0xqr6ptGRZfGhJ9X2reXl46RLCoX38WGOuLddxgk1U4kIRzbo0/
	 HjPs48kfpY8ohrOJznikSNw5kFZU1/W1EkebIbxCB0xMCx5Zta/4PQF+8nDYfLDNwaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PamtuYvd6WyS9C5t9/ckesrSJD9k9oetwFCqQaRqQ0I=;
	b=XO7+YDLJezHeJKrvzZhR9h70yjDZ0YK44V5RelDn+zm1AZibm5N7iVhbIyD3socte3Or
	 IxCB4xDyXK5WSCNcCKhyARDmKQ+uJvzeudynY6Wgk81W9t1MPlRRVnyZO9bCb9Rr+y6N6
	 9Ft7qE1vt7DuvKJMEyrAfvPh03g95HRiaHGFG8lx6WOtLF/gwn4zlI4P8wbamF1bSjBo3
	 NMZvX8l9NAGRLBEYMK4kDwFRzdAAoKvcvNKzbvB40BYtOF3T8DVt97SunYLnxq+fVaUWF
	 GiBYpizea9KxuIaQQwiygZLbQkhurg4LIr4c35nf3Kf9PZpsAX71s+PVdqZLa3NT6Kw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491756;
	bh=PamtuYvd6WyS9C5t9/ckesrSJD9k9oetwFCqQaRqQ0I=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xnd44RnGLsK9W/+PuOWdOQyEScZIqxGxT6+2jlB8nRztbI1ojsrtpftsqdKr8oZ3N
	 hZm9oXNE19utNpYjuBhj+vACnwrRJs2Drr9WRAqSZH1cagxOw38+pcOM4Dpqo8HDbf
	 73+VYa3l1iodtdEwiqweqcf3+YVYMAk8RUma2llXP1mibL7St0dpGMPJ3VNeH/sOHq
	 ft4ca+iHoM6sNdIdDyslD5pfhLm5O+JY3x5Uemav32n9mWNv6ot4dut2P/HQ26lS6T
	 WZsKIqeYoy5wd3qZ02gtzUCibXtExOWvUkdW/XaUEOt9vylTZtHpBFu3N8x7Yg4sKO
	 1k76sRZqPbzdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2015A810E2;
	Tue, 20 Oct 2026 10:22:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B0121AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C7B060825
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:22:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HbbVBGS95f-e for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:22:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9EDFE60822
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491753;
 b=ffYY5WBJtgNxDcP/JSc3BW3NqnlAvGmUdqdC9Fa6yPlWzisp0/0BnOjnk/PGdJxVz/5A
 dDnx3d6YBcPWh+ldxJIDNjrEf2FGtUL8xmWq6Zm6tgLvG4GyMQZwyZweY49nXlgPOlBNY
 3Pkt4cyNYJA9HtW4/zUBsTcTyBo5ymxqcP8uvFpZgPqtIjZgVCqYQm1GlHljY2CuV1XGt
 ZaQmjZzZGsixiPyYF2mNU8mh5eOFLbBv0TjVN77UuaGjV62Ttxs6r99I4M96z/5Ly1YXJ
 McBML1QQHal6rrJo82t1pw4uy5BFu2/tvEWKSo3kyM4gnYM0dOBROzT742g/qIMdZtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491753;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=PamtuYvd6WyS9C5t9/ckesrSJD9k9oetwFCqQaRqQ0I=;
 b=WeoMLROx9VJiNk0Ustlb7CCwfytRIEbjuOZGofsPtiiE2M5TfrlsaOOMxduUQ5E8MjZ8
 s5dzYrJlz/+CY8EFVFTRQyM+Fdk6RzYx5h3kKetum7mVhpXi8cYPd3dF5yJIEGdbYoW87
 K5M09yoaMCnF1zoAfU7qGX48vVWePphMMqvaQj5WIZTwsqBba7iu1eLB/bx8H03g+FWzj
 c9H3CrTbJZArYXxNaOJlGydBnkivtP5tCX/oNQCe86uyHtrvFg8LALGWlpOje6+4VpmC7
 CSQrRPHkvw6nDz5L62y9p3L4A9yEL049oMZFH/rdCmvj3ZdLAtS/8honkSP3ggIXCpg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OPIMxFXB; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kvcskDBs; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPIMxFXB; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kvcskDBs
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9EDFE60822
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:22:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K7vVE6185960
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PamtuYvd6WyS9C5t9/ckes
 rSJD9k9oetwFCqQaRqQ0I=; b=OPIMxFXBiipcmhdM8hxrbhjWR5b8sBempku7DL
 1XPDo/M8YagKYnaNj6QGB9WRaDEvyVxWh0qIeFYZmKvzRIPQirEh+ZXSwdPhiL6n
 LBp7ZVdnfa0Dt56tQWV5wLGQ3ok05AAZsFlP8/OikGw1aZmOdSN8QYdFM/ld9+FM
 UkWkC3KxNeaaaar9csw8Vu4QPRLjnjYUEXv1EZnow4EGSHoULOd500LyHm9JzkJ4
 vWS4evxhMUGz+vDJwvo0HAsDCal/sO1QW9Bh5p0Ha0yHJt0yll8NDlatgUoeJ/bR
 yynuf4V1BPh1PaDvSB1VRRSSafhlPhUBHcI+gVg8RxZj6xhQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nt1xk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:22:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so7651764eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792491752; x=1793096552;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PamtuYvd6WyS9C5t9/ckesrSJD9k9oetwFCqQaRqQ0I=;
 b=kvcskDBs+ebGtQUyCV0kuvHwebIsodetq25El0/pSfmXsafVcuRc7rSvtjO6Zh3KzJ
 B9JL6pdIIkNnMC3CPo6YWlkb3jO7KIUzDBBshuqm58pHguCFIqieYcTDJv/Tj9jGLpyM
 2anFktNhsTffvxZCqtuPOhwk5E/IGazA/YqKvbJEW5G7KsA247uLDnjmdkplQa5KWiSB
 T6mrssQsta45FO008coNDaGp0Qik+P9vCxKp+EFZmZqWVucEmNIrE+eYb9p8xEFE3W3h
 ARIbvPFTVLjKnZ62yo/ThlcwZB+XJuAHBhoRYtmYhzhfHHvUk8gL8gLCAYYOn2OmiJuq
 BWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491752; x=1793096552;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PamtuYvd6WyS9C5t9/ckesrSJD9k9oetwFCqQaRqQ0I=;
 b=gzoV9vnM/A0kNnQOddfASHKFfbuwN7YJVVPv+PkQTohLn+s5u8Ks2OvIJL3PIXfmpm
 bBm3I9IiGmXNOB6Ete9z3Fs5iBfY0RMUrKtIqiSo8gekw4omeqV7DM5/F9s+fPy4p4Xf
 E/V9foIIAzv5TrTlFStKIWqtueE6dojGLXS9SzOQpfkjnst2aifeGPO4MDaaDOEQhEHD
 CxF98bRhNb1/uYm1lv03mWXBTAZ7Ps/8NMfsgdCz8Jf3Vza8DCfzONA7VwQiamBZ/KOd
 Q1bSy0Y/rJv9RtNA4E8vfanCy79XTk07xsxTgTGfDXCUc/oitIHYp/KxWafd80J+/bHs
 L8HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFhtbAt3prBt0SowvtVhBBFlh+zAjWX1C9QcG56s1uvMPSDOxo7rmfZNFdcjmLh2hMe/9ogYQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLXMm/sJHN5H32lmzWhaIUQXmx4OGRA0G79+CJC/bVzQfGRDWPJ
 ggp72jU2QYGpXTVCUxR9O4pIQuz7XXOXvKcITW10Skc7MZe5m4qa93K3G50pT+s4Xr5HxSCMIU6
 Rv21UUo1+DHeyDvJeGVopzizXSpJQpoAj5AZ516qO1YpO3ZKmaIb1AuYLavnYv7tQAw3Wjz8=
X-Gm-Gg: AYBFou0ICRFelPC4ilmS3oLpBIRRcJybQsXTI3n3/YWP+S89/46XyK3Ntxo0qc3M9t3
 eo8WlTIsN6j/luTDKgGyw0hwS7uv0j/jOmuczq94HjhAc4JVUPvLnebcObeObvCG6rlvy+svHaX
 LyGiKl8IQ5NOIABuL54bzoY1uHEJG/keHiTTbf5iSg9yshYy+TH879lhKv7qOx+jYHg1BMLgaBs
 avFQCpE3PuP8Id7VTExhWvKCIBC1Y+5wBZBh/UN6i95PbWg9W4ru5bxMk771R9oLaS/6hNC8FiY
 4mZI12mJJYx3CU5EoEL4HfSFazbARDDvv8C4VG2iW5jYcr+VuCzEAHOEolTeZ8B1riHgbKxsmI/
 Eb22PULw9p616DDDHSqbwk7EhIEwcTOSEZH+aDp//7rjF3qtEt7C0b1Us+qlSpqvYYqmtumWfgT
 vHjDI/CQn03jonSfHX8aoATU7dnuI=
X-Received: by 2002:a05:701a:c90a:b0:167:4198:2cb3 with SMTP id
 a92af1059eb24-18512c384cemr13861858c88.18.1792491751669; 
 Tue, 20 Oct 2026 03:22:31 -0700 (PDT)
X-Received: by 2002:a05:701a:c90a:b0:167:4198:2cb3 with SMTP id
 a92af1059eb24-18512c384cemr13861831c88.18.1792491751117; 
 Tue, 20 Oct 2026 03:22:31 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm32155066c88.8.2026.10.20.03.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:22:30 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 15:52:25 +0530
Subject: [PATCH] configs: qcom_qcs615: use talos-evk as default device tree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-qcom615-talos-evk-dtb-v1-1-ae2d2b48b0c7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOBA12oC/x3MTQqAIBBA4avIrBtQqaCuEi3Sphr6sVQiCO+et
 PwW770QyDMFaMULnm4O7I4MVQiwy3DMhDxmg5a6VlJLvKzba1VhHDYXkO4Vx2jQkibTmKo0doL
 cnp4mfv5v16f0AR9JvrFnAAAA
X-Change-ID: 20261020-qcom615-talos-evk-dtb-ce2eb9b54bcf
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491747; l=982;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=byE/XiYqlJEbO+EuhdckOG2eZO91rv1nOXNMT5S+BBI=;
 b=gZYorDpRWjzNFzMHO41t0wlnDFajfhImBQy/FslL5qS2PXjd+JI3c1iHo3VI2JgMibCFh2XtM
 PJo7Pu4r3sWAij8JXjhz+/97tmwX1FVP1RPibygwXcc2TlperxfaqxQ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: yV8TxAwlnyrTKIVFLPsVIzbN9IvBTkK2
X-Authority-Analysis: v=2.4 cv=DZOCOftW c=1 sm=1 tr=0 ts=6ad740e8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=WomESPEAhc3mZWdje-YA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: yV8TxAwlnyrTKIVFLPsVIzbN9IvBTkK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MSBTYWx0ZWRfX/OEsnuuX56Ys
 T3VnSX4+WDa+d8iAYn+GmbdKWsWS0Nd6WX8MsfrHa+6C1cuFMDBvLeIQwcznmD9WYUs5Hnr5zkC
 LjrEP93UvdW6m6Er7f5bG7yJMMLVYlti5lirP8CyK4YtpZi+U6Wydf4ue3yRbFqI0e+SGJL8wUl
 N7zEifsD562TR8bOngSMBqHOuEL9p7SLgFHuh65oChmqycJXClUoZXlxrbFrqxfRfujK+It4RND
 mWrUjI3aCzpqAjqYVfRpFMKx88RG41f7hF067SqnOKdiChuK+i2WMxONrZM/eJGeSESDsWsbXaW
 j8ypNzVZf1eAUqPlFtqs7ZZzLN4YT4C/4JZadPwGIpLDxLxd+M5MdSe3RDBlSC9dwm04YAXG3la
 Y1Cw5HM+k0cIL+5QzkD7K3jftcVcFWluDf1/+sYpWcNU6jg4eHms3bR9GHn9+wYCjBb6JwEBIxN
 rYJ1HM+YJ0kFCBJ+6fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MSBTYWx0ZWRfX2AociudKaAWW
 rKBAQq/IkzDa7VeyOc861Iu2hPllZNA2gBQCxlpwqZGfr5pKZuvRjfi3E5CjQUinz/OELoSCMq3
 kqiqNPTDU7hTxS8FFqkB+wAWqAKHH68=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200041
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Switch CONFIG_DEFAULT_DEVICE_TREE from qcs615-ride to talos-evk so the
defconfig builds for the Talos EVK board.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index ccc3bf24ab1..4e3e97e6efa 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -14,7 +14,7 @@ CONFIG_DEBUG_UART_BASE=0x880000
 CONFIG_DEBUG_UART_MSM_GENI=y
 CONFIG_DEBUG_UART_CLOCK=7372800
 
-CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs615-ride"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/talos-evk"
 
 CONFIG_QCOM_GENERATE_MBN=y
 

---
base-commit: e36b675ebc4c41f1f4187c46d363d581c371d538
change-id: 20261020-qcom615-talos-evk-dtb-ce2eb9b54bcf

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

