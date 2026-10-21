Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B2606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z7ugSvzg;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iQx8/I4W;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RXYSFi4E
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B019608AB;
	Wed, 21 Oct 2026 12:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRAHeZySqXV2; Wed, 21 Oct 2026 12:50:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 738BC60803
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587020;
	b=TRUrIQmXcaq5819SlM9VWFxHJMc8OAfCdTotnYT4p6vBQdMrTTDjWWimz/bDniS4Cq+S
	 D3A+qVRstktHY7VM5RQXVdwvSP3n8mZa6uep52aTE6D5JFYQTPWJpAxq4jZlDXQwiiIp/
	 X/ZUPulpIJUpJcL7T7O3EwQ4vUbl+QCKllh/2pYOZuKWZ5GbuDgFx2GVG6sKSJgygW9vv
	 D+k8XM1Y+VW96pqw+oW5OD+H8yuoIvU2i4YAoz6aJHuuiBR/5f/YtlFP4BB795LxW/RV0
	 +n1Tm2+s39RsaYf9CtW4pletLL759lJlWL8nzgq4tFGa5jb1u2U4ZUUiAxHxVetTF3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587020;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2l5Uf1RVmKHQ81OjXLdeg85sSJa2KW9+cjRVfA8gJxI=;
	b=d7FezoUO2ya56IsjQCs/l/iWN7XxbPCE/9pfFr6aLPJOKF3CQtv73HZobN4PjPhCx64X
	 NICpdI8CQEIWlh2xlnxzgf4M/RFWdeXcpL48zoM0vk3A9w9cVk1MYnJFD/c06F73owkLC
	 IzV3MMu+i+r+4aYTDTd1Njp4AfhNB6fZbEtTnN4xhEbEX5lsdJIi5i4TMzVDgsDQIEpKd
	 5OovKsSCbJhEQapZ1/VNDEAmcvn5AYVqbG6wvNfNzN0IluMYkvLaiiMi9m4mFXSJD5zH0
	 YYKMO+kMqm9bd3Ed8JA5dpQ0wtZTRiL/n0Dg1GOq5EmpTzyMBkCcQoDawj8WEk+w2MA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587020;
	bh=2l5Uf1RVmKHQ81OjXLdeg85sSJa2KW9+cjRVfA8gJxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z7ugSvzg/eksMsYaNbkeFiIWH0VOYD0n8DmnIOR6+bkK6BT2DgInMlTR+A6G9xkMu
	 a+5KgFq8bQCsbN3ODRfGZuREND9uXt6XZmmBwwFyCptZBfhBKwS5FeUuQlVWnPL5kv
	 Rhz3hlncxBhHqEWeWo6EyxJx4JZkS3E4r0sJDUoOussPhMVobBZErl2fkvXSIXonzP
	 wVBVqUPeMX3kaaxN0FZQNMR1QpIgIFtIjoB3v5+0qVW++wPpaNWsCxKPOwLQrEsN2f
	 14uHyu567bOixE+RFmSWePN7ZniUotMgBJUI6V+t0J08MrErJgVSRG9rBnItMNAC3t
	 +c/hBcVDoEtew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 738BC60803;
	Wed, 21 Oct 2026 12:50:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 989BE1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A8A3403A6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GHyKfbGkax8l for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:50:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BCCE240399
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587017;
 b=ghq5RdomDE19iDfZOP4FsV0v2Y+1YY0xp+8Ul+V481PFW4cbdLr3KLaiHiVj7pNqVFdN
 IWqNV2lKmDqfc54n9Y+l8ZOiIeqzvjf22gh7XWBadDFfXsLmQy8wW4HLr0AlrzB1PiUSL
 HIv4sr7lPG3KX9saCPli7TFSaku9bqvSIjTyB41kuF3zPPI9GP8/YAJVapxzMZfAa/3LZ
 CJ1J2iEbNbBxgxi68RWmEtZI+H7bEG1wZzAryLSFlbubFuTEgN7iVXAAq34Vm6mFJvRLC
 eyuNOOkqBzJrsHi0hIvNgqrTuSby1jZDlbM2ihf0M8+G/zkctr8X8Gr2ntaGNqkweTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587017;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=2l5Uf1RVmKHQ81OjXLdeg85sSJa2KW9+cjRVfA8gJxI=;
 b=WRiwTlGlZEK9oxY9zUgEbRNGsD9ge8gcDVet70FDsEvTncMZizpm0MJVJDE/0PddCLbF
 lUAt3Ha59z5Vsz+7K/HXtobGl+a0Uc8pkP3tKyTvfMCMQAwtm0njpP6tnhaeGoXwi7F03
 guBk5xPGWHJs6CKwoAlTZxHOGuDD2e9EDGWKZyGcj30iLB5rkSaCKx+2mDgAXymX5D4Sp
 6+mm0d+Ck0s3vKS5d7t1K7zmjrhIPnCHyXOwUavh0AVx6XBdwtsLMzAEZEwYV4dxowcWO
 FmrBewwU6g1ppnN0wxwuhrJQph8IvjsrxknWabfyoiV/+vupxPgLYpUKpSVRg9QIIuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="iQx8/I4W"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RXYSFi4E; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=iQx8/I4W; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RXYSFi4E
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCCE240399
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBfw5P543857
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2l5Uf1RVmKH
 Q81OjXLdeg85sSJa2KW9+cjRVfA8gJxI=; b=iQx8/I4Wfqjy6lgrjnaEvs17FR+
 Hkj8xm0MUvmAxldWhPlsTgh1hhB1oH69ZHl+KxBTtJRSR+WCm+ksrmZYmnraBWdV
 MWSg7Xisd3M/niOULAcbds8n4wKULKcrkB4s1eczTvOfLRzZ+B5LENGMXUQqtuqQ
 cjo03O1r5w4gzZgaiY3Wn7nDCX7jldSZimSwdhaRi8J6ogRPAQEqWKmMCrGuqzJK
 arr43akxFIzsJLh4wrInO4foU1tKS70elgcFrPnxAzFr4yJa6tRBzf6Wj/F+iAmN
 n9v3u3Eb2OFV1/tRK8eIwLnD0GB83NCGDlCk87Kzum2tXBEGEAi99txAmvQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj48rdx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:16 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso1548969c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587016; x=1793191816;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2l5Uf1RVmKHQ81OjXLdeg85sSJa2KW9+cjRVfA8gJxI=;
 b=RXYSFi4EKcb4D/tSurbrubGbWTE+bGL6TON2s0lBawsWyoQdeXBiOqvxD1TmAO5Ea/
 BDHZGIrITKF/FNA2qyPSpSaSgeU3sKlCCJxLHeTyz45k17GwcAYqXqk4Tl5J229ZKt9l
 Hhg9NHYo39AB8DegTzKyGT/5GbjbTm5aVjnz9bU7/IOlnJWlv01hyAlMZgkIKdM9zJ8J
 qkP/gSW6pM+/EXZZWe3B1Q0SnEiT5zDtSNnbS2J61XfdpGkIkitGZvlM3j7i6lZ5pDQ1
 3bktH462/HpKOl5Fk6u3od4VbhdOfoH/sQ1/kZTjZwsmsJBy3HEXje5D4QeiEB+4WveZ
 qNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587016; x=1793191816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2l5Uf1RVmKHQ81OjXLdeg85sSJa2KW9+cjRVfA8gJxI=;
 b=genKEmkytI7L+WHZuoQpdEQTbOlONSKZ20JRLzfu8RydoNY5AvzrvNCP5X/T5Y6V7u
 jMsjzdhvq+f/lO5cwE2A+e5gUd/boFDXSMHR1l8rwcLMPwsgAlYW8WpdNO2MRke08g2j
 zycWa88DFcI90ocpaxjat7kwFUrRk2CekSqDvOvMd/CIUhY7EiNN6R3USsRkHKHYSWfJ
 iEhxj70bKVRcF6x5F2OKkF8KQ8eppWymtiUrJdSOFVCBszxgYJp0OTpeDCFndvvcYjkK
 iVqV9vRgPGM71YibMPFWM2kWI0yjqg3UecggkgHw+/9yXDgn54t7nL0xEF+10NYIUl0B
 hSQg==
X-Gm-Message-State: AFq9FYIIwRrWU7WoexewmetxLpMtYrRCGoCs2e5hD+uRoiGm0U7GzTUV
 4Tj2jL8IioMIq45/bpckKuw3CaRBXjtdSfLPbTAgLHACAOaHlZK9lovl5KXmyv3mvd4bWsrx5Io
 2pe6b+ERCXW0bvevq1PLZlsuzaaP+NT+nebi6+rnrwTmhEy7tcspMaWem2JNfGs+0H2OLCfnNlu
 W2c1A=
X-Gm-Gg: AYBFou1Eh8meemPsA1sk8/uN1A2b1vUoo+4EtM9hpw7XNU5AcP2JPXLac0IZ3qdShdy
 ImHBaB0bV/SzpQpgfbYIPEnX9p+GLdUF+AQC+jgBex0h9qa+tBGiWkrOSQzImgL1PmTjxrgsLsU
 8u/+AVCoBkR8lhekmTKv7BRxDReJJpcj/eIipjzx0bk3mcUFsftUw8pVS/20gcp4Bl1OmHj6cWm
 oBsvzt7sYnL9DJbAalF6t9AvLr8HwAflaCUm2oF1qMU4O20nydQNH3p3EhurwjSlVbtiqYii3He
 b09oinP6eO98FYRgbNqBv5Dt+8W0dLePHhhlk5RxCr+X/tpX9Fih3kIE+BZgj0NQbc6JxuDO1AP
 CJ2ic0qEEvpZRQqtetnqQyn2gS29uoOG3y1eRCJ306DaqcOsQkFBhiXFQYgv/mnifrbKc3GtOHN
 YAn7x1Uhv5ul6DzZgwi18cyAiixkdm3CbDNXo=
X-Received: by 2002:a05:7022:28c:b0:151:bbe4:b6ab with SMTP id
 a92af1059eb24-190a51e65f0mr2237555c88.17.1792587015804; 
 Wed, 21 Oct 2026 05:50:15 -0700 (PDT)
X-Received: by 2002:a05:7022:28c:b0:151:bbe4:b6ab with SMTP id
 a92af1059eb24-190a51e65f0mr2237523c88.17.1792587015134; 
 Wed, 21 Oct 2026 05:50:15 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm6467815c88.10.2026.10.21.05.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:50:14 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, trini@konsulko.com, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, Varadarajan.Narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PATCH v2 1/7] clk: qcom: Add RCG post-divider rate helper
Date: Wed, 21 Oct 2026 18:19:57 +0530
Message-Id: <20261021125003.2948090-2-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nACvmkbnNRRqKODpVbeG-ggkIAq-gf8G
X-Proofpoint-GUID: nACvmkbnNRRqKODpVbeG-ggkIAq-gf8G
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad8b508 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=fOfmqwQQv5T0lJ7gfzsA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfXzj+97oxYA1tZ
 nxUsK6B1wcSFoDPg/qZ/kf0VxrKQ8A88SQyZ6xElIygN/UJUgUmHC5WC0fTTCCR11SQvzu1GDzm
 oLl1DdRrP66zCFJlf8AQpV8/QtzCLhiHHMaAqsHz7chZxDtOgmt803VeKFbOWAdlCApobN4OX/D
 wr3g82kTL+BRT5CR4UeY2cGAzUSdrGKa1o3r9jRjb+xKNbuWc130x2SEFwearfpDbSDmakFGNIR
 QPBUY3cIyhCB5xOavS1aH3KR3jLSn3ZGLoRW6CRarN3e0dpL60tSrEMakF2U9ZCxVj855ru7kbr
 KM5bLdv2isFMe4XaeThFtXFfdwIGCIQAY0BsC89X48EArihOEX2QAWMtEdnALK0AEe5zqMWRfX4
 LrDNpNuffqOY7po18A0NrSwe8AeslehZPMzaO4eDwWPPBTIF5YCOWxM0WJeoJyhtct/s9pHFb3y
 R8Qjlxa0KGRmjvE9KzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX7SYi3nBmrNgI
 AqqRIxbrOTu8ZqyA08slkcdOvrdkfiEoQ4Kw0gU2TFngpq7pYrduIoshqVSQSFutK0V3jaoI9TG
 Pw0geQ43Mbu8BsvLkUcJRUfGSDhZM54=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210051
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

Add a helper for RCG rate configuration using RCGR divider and
post-divider settings.

Unlike clk_rcg_set_rate(), it supports fractional dividers and
post-dividers encoded in RCGR.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..0e6ca36eb2e 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -193,6 +193,29 @@ void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 	clk_bcr_update(base + cmd_rcgr);
 }
 
+/* Set an RCG rate and an optional post-divider.*/
+void clk_rcg_set_rate_with_post_div(phys_addr_t base, u32 cmd_rcgr,
+				    u32 post_div_reg, u32 div,
+				    u32 post_div, int source)
+{
+	u32 cfg;
+
+	/* setup src select and divider */
+	cfg = readl(base + cmd_rcgr + RCG_CFG_REG);
+	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK |
+		 CFG_SRC_DIV_MASK);
+	cfg |= source & CFG_CLK_SRC_MASK;
+	cfg |= div & CFG_SRC_DIV_MASK;
+
+	writel(cfg, base + cmd_rcgr + RCG_CFG_REG);
+
+	/*optional post divider*/
+	if (post_div_reg)
+		writel(post_div, base + post_div_reg);
+
+	clk_bcr_update(base + cmd_rcgr);
+}
+
 #define PHY_MUX_MASK		GENMASK(1, 0)
 #define PHY_MUX_PHY_SRC		0
 #define PHY_MUX_REF_SRC		2
@@ -252,6 +275,16 @@ static ulong msm_clk_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
+static ulong msm_clk_get_rate(struct clk *clk)
+{
+	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(clk->dev);
+
+	if (data->get_rate)
+		return data->get_rate(clk);
+
+	return -ENOSYS;
+}
+
 static int msm_clk_enable(struct clk *clk)
 {
 	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(clk->dev);
@@ -379,6 +412,7 @@ static void __maybe_unused msm_dump_clks(struct udevice *dev)
 
 static struct clk_ops msm_clk_ops = {
 	.set_rate = msm_clk_set_rate,
+	.get_rate = msm_clk_get_rate,
 	.enable = msm_clk_enable,
 #if IS_ENABLED(CONFIG_CMD_CLK)
 	.dump = msm_dump_clks,
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 9899cd28aad..297a5932227 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -98,6 +98,7 @@ struct msm_clk_data {
 
 	int (*enable)(struct clk *clk);
 	unsigned long (*set_rate)(struct clk *clk, unsigned long rate);
+	unsigned long (*get_rate)(struct clk *clk);
 };
 
 struct msm_clk_priv {
@@ -115,6 +116,9 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, uint32_t cmd_rcgr,
 			  int div, int m, int n, int source, u8 mnd_width);
 void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 		      int source);
+void clk_rcg_set_rate_with_post_div(phys_addr_t base, u32 cmd_rcgr,
+				    u32 post_div_reg, u32 div,
+				    u32 post_div, int source);
 void clk_phy_mux_enable(phys_addr_t base, uint32_t cmd_rcgr, bool enabled);
 
 int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id);
-- 
2.34.1

