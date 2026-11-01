Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A522606A325
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j3bd5LXT;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fwIe7qc7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HKQjIPje
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9719D80C66;
	Sun,  1 Nov 2026 10:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6jaHBb5G85e; Sun,  1 Nov 2026 10:38:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9BEFB80BBC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793529529;
	b=b53AFy93inIHZYgyib5tY7E6uBYQiGekvW0F0oPEBR0d/6HJ+4YqvaWxJABWg8RNTr9g
	 8RXYFRnBXkosBtzQ7Ol/eiwkv+l3FmkZt/TPQzTYVucZj1JXXzIwPa36cdA+keHHkm6Qu
	 PEpnh24aIbdsXr1sxEiIRz0gsySqL9klC9LdHyOHXfxKUAIQexOpmGIosnFF6i0it0KXx
	 9/4ox1RVFZJM9sXGw6ThfgLyTvsUEByfSy3UdjczAHG424/b4mppK+2LKLljuTqODjvN/
	 kb75saRmtCkt+qg5nY1CiD2+fnqwzg+hVtFW5KKrRHaFXm6Dx0b7TkMPEis1APCp6ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793529529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4/7JUbv1o/c1cajPiqnPbGdthFMbEtMTYe+Ji+FY0YM=;
	b=fwETIQNcOvidardNDyxaKN1IB3f4A3ryDMzCxLiWmZAuorqyLFf2sKcqFRNAFhgjU1EF
	 DW/SuG5IdJvBhz/vJB+9W/SeVrXytKz+pB1v2w5mQvCCDOnGEHXUGMH1C2y1m+dHwfsHz
	 /RLPaOJskyE4nZWSJ42LuyWFR85zbWcrTWX8dEgnsnNz9s7/FVAOSdCR37ac0za9ysCS1
	 TvbTmh1hUkaH8txNwp4tvKNdi0SMICAi6NPqxm8hit2qJIwMxOs3Zrynf/g5WyatdaIac
	 7YPOD+n8HQ9PsYxWTcRtrAYVT0jcFDsxRuUoaPQQWlA+SzH2iuXolv6kqWvc5J6kN8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793529529;
	bh=4/7JUbv1o/c1cajPiqnPbGdthFMbEtMTYe+Ji+FY0YM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j3bd5LXTMECjzz/gONvsyaP/bpWHyKdDBCRblkpsDJHx/zBNJ6baQuCSysR7Qlmmm
	 96UxLv9fB2NbcA6gXju+ETt+THbJwB7Tz4qWt7zHxIeYE6ysHW5xyiGY0WfjBc/ZrM
	 G8gNOALUY5Rtboa6mP+PBIVETrXaD/pFIZB+xD9h6ljy90cJI2HvtmePyeUmCr2rnd
	 UjLKHLk5wT8bViYmpUk3ufGYn1KX2O9ORjhnLGSK7vdaGNtE8CdZWPtfTO3bXOzqC1
	 PDL7eZBL2mtFpJeKUahnorX1AX+rpDaDfFvi7iIFlKIEplDzZvMS+UpJcUAzCr5VHh
	 E0vslMJ5xXg8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BEFB80BBC;
	Sun,  1 Nov 2026 10:38:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CA762AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E650405CB
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REones3ksfDf for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:38:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 697E0405BD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793529527;
 b=cM5IuZ7vUPnlDkSV0BTNGOPPSWX5W0UcYg6+bilVdGgoIob0xSMDE6P9dpHTPll+kKqe
 L9Txj41fnN7ytCjIpqs/6KpPW3tCotYIltDKmX3x7q1i+bZSeV+80BlkmMg5GZpm7JW2N
 JS3/j8u80gyb9FZiUKiUhVbLImsvEC2OysNNCrCXFHiJOyG7dsqD4Ufq7weDGW1a1gwJn
 qkfFcXJWBnFvBFIaXKKqKQMpVRJ2XnsSFsTccD3uFcXAoJOze+N5DLsBmRhv/OGCqK20A
 8g4wkoV1FTbRJQlNcySFQqPcdkedwJ9Thm6FQkxZDzrOO32SPGs8E6+KeilsZX53FGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793529527;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=4/7JUbv1o/c1cajPiqnPbGdthFMbEtMTYe+Ji+FY0YM=;
 b=hih6KXjjFUx1z9NVEV0ioh5ggsjXZoXPg2j5Pt0PHWoifq1XIC/D2RJedi1Ddt8Mvnhi
 gYHiWKab85UPNdjQEisFMAbGaWNxng8VBhGpCiSpTRsx+isqXyU7fW6qd6ZNVJuI1AXJ3
 Yf6v00Bp+jEfmV4OMCiZ20HWEwuwxhXs7doYEkxwGTNyesf8Y/samX3JCf7XUQ4RZMDe/
 ImUJyQZfvmq8ad3Ole488sgZwwphffBRbE4tSEc1C2IYGWGFFIVzxdBJApDwo4JrGOxRh
 QrNVe5QeiiTQ7xMSIwilXA22a8ZoegFP90thYOo8w2yBmudzQdIuC8N63sItsSBUbRQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=fwIe7qc7; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HKQjIPje; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=fwIe7qc7; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HKQjIPje
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 697E0405BD
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:38:46 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18K6qX1359347
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4/7JUbv1o/c1cajPiqnPbGdthFMbEtMTYe+Ji+FY0YM=; b=fwIe7qc71DZFhH8q
 LxT92WG/WrIl19ibtK6+UBBng24SAkisF8zsooVQpUqiOaQQNv/oO1jTYEPodO0M
 vuxv6Rjdcz56inzorsqarMtv8PK0EI3HbHrl7LFQAxAELnIHkXZcXesdxBCsoiQG
 f2MNUz/Y18NT7vJVPYsN1XYNkpk1a3rRJqYNI1PLkQFFet0JTR27oJly7zrd6Z+E
 dsjSRpZNsUEuxIgdmfnIazMGvIKYZQQYQkVFFjmLQDMBThuQdgm61kX8USfM2/yK
 7MadIqXBsNqZ33fMC2pQuVxapO9YCjYH1mxOU88W/olq+U6Xyc6tX78rB9ridDa6
 3uahog==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn79ru9ag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:38:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so4263916eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793529526; x=1794134326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4/7JUbv1o/c1cajPiqnPbGdthFMbEtMTYe+Ji+FY0YM=;
 b=HKQjIPje1kHzXUksHI3vzzw+NPI3JtDMlTvJUPgiAcgryaw+TREE2m3KI7YcXXzcph
 FGZPBur1kAvIzGNf7qvR+S+JI/Vz3cDvUWrYlIwZXe1rSnIY9Wr7kbXJg4q+kKL2AueX
 eRhm3coIeRt2OUXgIpt9fweu97MYrP9XwJmy6o6hMlO3/fvmUO70r7G6g7TF3jr50wj0
 W1TXIGp37Hk1MPyG5hbqKupDxIFejuzomLUZno/gAWOW/zpVW+owa7obSJSTXZNKHrFH
 rlRsKvtDSfj7KgvjtctPe8JBOsprlKtC9y5ydobW51qg3WxBWkfZx6yZpYYe1zL5nbpG
 kdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793529526; x=1794134326;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4/7JUbv1o/c1cajPiqnPbGdthFMbEtMTYe+Ji+FY0YM=;
 b=1Fg87iDirAKgMlmVb0ZIth6ufeLfbanOpRqZ/CBuCvZQqmG7h2FO7MpkA0UkZl6iqv
 Bjw/O0OJrjc6+cqSnY1XHb+/LbixST36iQEBBYtv92QF/3Y5GUNTkFUF07h85t1KKnwH
 wpla/DXTollVHT1wS2uf3I8l3Y+kWixGUOuv4K5amhAYsL50mTf/JQU5cmX9TGpTUvwr
 2Kb0qehM2T1KbSdeEmwymN7DWcBa68YsS0VREJK9QFuEO7dMkDxdN1XLMmauZZibe+z2
 AxSooWVm4RQ3EMqGo9/XTAwpFIKR+TiCM9yq4pX09dN5rf2CVbO/8I30HbEkwiTPNv2F
 FKvw==
X-Gm-Message-State: APuU4Z/C3rh/cO+stQF3P6Vfy/cast6WYPQZo1PS3LgFrA68qRVqWfMc
 MDURSPrhcC8OSC7IJ7ObKaZoqqVUq/EfakCwIf0UnH4/AiVXwauwInMieKy3ZZCtw1m4ht0I/54
 Z8WX1nbTamFsMXBFX8sDTaOxPUHAlJSqhwg06IikNt4zDMDycJMKoQkSW9UNxU7hPMQK5XLY=
X-Gm-Gg: AYBFou0QwraTR9RL7MpIOsyzDQvEMEETEirsZEc8adqGeufSE2AsqKXtA8r1rCMHC0D
 kOs0kBEHMdnuOBlhHyes/k0jkNJqWdGKkh6Nncv6OO38hBFXZnJMTHmqsq72ZDcFWl+AZWZABOl
 ALzVp2YzugygN6NLKbMqUayq02uRI6NHNoFeAqm+Cdr9lj4e0cMQ8tyF51U03b++vm28lRqELOJ
 VaHDVvZEewUYEEzv6kaM2vscwFUuhO+HKM0od6I30hEzRwmNRHgbJiDHAHoeIUFAZKd+ZBCmZil
 2sRIpDzTNqkf5WU74r2gYsVFtioriUuMjNi19Ew9oBJr4kR0+DNFEqt/RdRi39X8lRB8vfIoDJJ
 7wGQNIoZiDhVG4oJ66o05RejI7Pqgezc1qTD8vADz8oOPHocftcFuNj3ib5rUpVPvMf8oxo4oqo
 kH0/iPT8ID
X-Received: by 2002:a05:7301:4246:b0:368:7c2d:a612 with SMTP id
 5a478bee46e88-36a42345878mr10757773eec.10.1793529525574; 
 Sun, 01 Nov 2026 02:38:45 -0800 (PST)
X-Received: by 2002:a05:7301:4246:b0:368:7c2d:a612 with SMTP id
 5a478bee46e88-36a42345878mr10757740eec.10.1793529525020; 
 Sun, 01 Nov 2026 02:38:45 -0800 (PST)
Received: from [192.168.0.6] ([183.82.206.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428c17bdsm25293658eec.6.2026.11.01.02.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 02:38:44 -0800 (PST)
Message-ID: <9005b07f-7e01-44a8-b5c5-a67a70b79b4e@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 16:08:38 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/8] soc: qcom: cmd-db: Allow boot without CMD DB data
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-5-18ce3e431320@oss.qualcomm.com>
 <20261021174805.GD3275858@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261021174805.GD3275858@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1n5Wnl8tWXMDXLnjIniJqQPcaJQ5F373
X-Authority-Analysis: v=2.4 cv=Wtq+otfv c=1 sm=1 tr=0 ts=6ae716b6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tp4+1iC1jwEXx1kf+84ntw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RVXggkuZOqXlY4FnlNUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MiBTYWx0ZWRfXzW5CnSUM4PwR
 KNSfrmX7XrbDTHD8Fv8aDfi1WeBoF9MX+FR8KUQYyhL+q6Fttjy433g7XERPrXXGNe/1i8XgyLp
 hZTC5PElQDYQ6D1IdbsIDOgX5+eDvlM=
X-Proofpoint-GUID: 1n5Wnl8tWXMDXLnjIniJqQPcaJQ5F373
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MiBTYWx0ZWRfXxAxwpbCFOHUc
 5iaheAqy80YcAnVYdPcckU4ynNnkZur9Z2wMRYHraDinF/qA2a9xBcXMhQe5GV7NnoGH7tC2QYi
 1h86oiv3h/LfMBCPDptoaqFOzFrDx3IQjuHdlgWBQ9a68o6ErgpeN6snAuxeNnU5R2gt8wr+f5V
 AQnxHLJ0p8hB0l2kxyDpTBfPBI/kEfcLwNKcih4YJRxUQHm0edxF5h/uskHsu32MtBzRxSlEvtO
 6D+gFELPBB9zlfK5VqkgwcH0CZbA6W2IV4zqerk3Nxl4HiBY7OQQsory73xwgdi9OjlJiWzWpdv
 6mFVVt0yR34YWdTfjp3EVtC0SH+5kwXo0zoBisSaW5IpVlWWn+Yt1bWvjkkh5hbkKCpTIAUod+K
 CRBFbpiDtP3xxmWOZ0LSOCbMDsu77BUM3Cs/v47N4H5Xuz9pYXUh8RJ+iuji4zME88TVK7k1bwl
 qSdowoub92RHWVkgFDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 10/21/2026 11:18 PM, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 09:48:24PM +0530, Balaji Selvanathan wrote:
>
>> In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
>> The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
>> boot even when CMD DB is not strictly required.
>>
>> Use QCOM_SNAGBOOT_MODE config to allow the driver to bind
>> successfully when CMD DB data is absent. When QCOM_SNAGBOOT_MODE is
>> enabled and CMD DB data is present, we log a warning.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Can we just not build this driver?

Actually I thought of that initially, but QCOM_RPMH depended on 
QCOM_COMMAND_DB so when i disabled QCOM_COMMAND_DB, rpmhcc node was not 
bound and that in turn caused issue in UFS probe.

Upon rethinking, we can remove the dependency of QCOM_RPMH 
on QCOM_COMMAND_DB as this is not always true, for eg, in Snagboot mode 
Cmd db data is not available. So removed the dependency and added stubs 
for some cmd db APIs (to make builds pass) in v10: 
https://lore.kernel.org/u-boot/20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com/

Regards,

Balaji

>
