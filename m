Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B887CA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29550608C4;
	Fri,  9 Oct 2026 18:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gU_-DCv7h5dw; Fri,  9 Oct 2026 18:14:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B1426069C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569642;
	b=dCa5O0rF1s1w3tJcGCzzpUCoIlEpblTIx3i8e7n795LCV/Hhx5Ob1NCz7m3TKjjNKCrH
	 7LT1kmjTIS3hQ+Vs+V3gpQN7hpT5tVrBZpqS8ULnWtgPgSHh6unt/lratDGQTlhIqBacQ
	 hCbjW2U5S5dxNIA1DDjFSW4scrybAz0WhMnvJ9tn5u8t+xV9G0Lnh1m3lK5kg7LNhel5e
	 UJKR7aAVpNMw1uJxaURTaeOQh1pGpE4N4vJnCNi0E6Ahvb6GzbU3tsUvYIZ3ua9geQ/3v
	 aYUo51amZXJPFit6SWEmwD5qnvuR97t+1dWQJbtgyBP9Py7hbibYDM6kLHSpm0lIKHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b7PCQ0LgHOV+RRmKKXVixRZPTdtBXQEKQ2i4T1BqNCk=;
	b=L0UEg5vrcCakkWSiyMc8+qHEo823EB2QgPHHUmzpEz14X0tMMr44AQWsjgpup/QmpWuT
	 sGjVhz9IFGcQaFZyqhqnKBD8PGVQI6kDivihNnj8lgEZZE1TIFzRIcSCySI6BtePbBsr0
	 b3nC3QIYKGatZsAFysjlmPLEEI2uuaJIdSz/z+WZlj0qBoQKZffgKZoLdJKt722qGLuF3
	 A7JPEGxfeXiHTCGHn1Xmv1MxCiZlQUGbAqNyozGuJ70BhbGNojDha5Ga9YLeqx2hhut6o
	 rkAahbEKD858cv2Cd5tKVpmU0swWCaKJ2N9HAVndFHGs4q3fyUSwvEYapuy5NvFoUJA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569642;
	bh=b7PCQ0LgHOV+RRmKKXVixRZPTdtBXQEKQ2i4T1BqNCk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lY3xz8etZeQ/p8fAT5zeTWXFyZB5AHi6oC6907qKt48LNy73u/ogwcmEWlnNgIBsW
	 01Ze2u6VQPFmHNpccy4WToQhMdxkreVeOOd/1zpj04Mm/ywoopV7haDO8I74IQxNCN
	 1xNa1OITzt0u+in6dv7fwzuLZ4OVRhD8I34XIb7qRotVKkVFh0oWo56gSdsJdPyhow
	 RCvThKFtTPVUwwY2yIAol7WcWFLZ03r7+qfAiJuzJ2gnKeG3kzvH08JFc6TEk8xq+X
	 wjZr/aLUuLWhNqI5ZuO90RG9mo4irNFaVWxBJq5X6uru7LwpREZd46DESVj/aRilBX
	 STTj9rCg7VxTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B1426069C;
	Fri,  9 Oct 2026 18:14:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 26418184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23F3D4016B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QolRkKYgXrxt for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 18:14:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6F85140053
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791569640;
 b=S9nVWwncPHtzL8aAeJJAs2Urju3c5GwE4mHVE9Os7Kb71R1oVaspjajigqET6gqhXs8u
 XWyH2nhYy1XuHAywQm+MgLrXJJ1Ne5XBXgho6Ttcl5w77Ew8jmsIgd4I+JINSS+tEs5ZI
 3KhIFJcdS7RXgDBpnh3oBIfFP59VypkEroy5/QDD1DZhTt+t80UEpWt4LP7W26ydKKOa5
 pP4A5AocdKtagjcwLtJ4LmkpmZKmjCjigPplu926QBgKq2v7XOXHqTlXzCeEE+y/SKbfE
 t9Ly5SZE5fVCmaLqb6Kyg9Ca6EIYKkEuFLMLDSGEW8ixdw+iGb7MTJL2+s7tK2F79Zg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791569640;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=b7PCQ0LgHOV+RRmKKXVixRZPTdtBXQEKQ2i4T1BqNCk=;
 b=nuUXjw8N+B/Xv+hFBfNNOeBzaiucOFfTMw/fzeHNTBwLaiZaOpBbIY7aEwU60/fJPwf+
 R+6dW/UybUaaYOrW6cZoHc9j4UPOWCK8gzKqz14N144yNScO9BMx3ZCX2pk31M8Ybp/5h
 pseXnkZ7P74fU1miGuoUMe3iQup/K10tlGiCFqyevlfpl6GhuzZjnXcDkmKrIzvQ3c+6R
 wsE1fl/TJd/EZ9a/COzGyUAGUOPXQPmynzzrF9g6iuBA8ZVNpssPTsuUjXvWsGUgV+54z
 2FuPFGrr+X0Y6eD9Yx5g0e07xviH6FdHW+2Q+i95QOLUdDKHYZwVNCYJGjza4Nntz7Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MBd7HXnm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Sr/bQ7uQ"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MBd7HXnm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Sr/bQ7uQ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F85140053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:14:00 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HaKEN1447691
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 18:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=b7PCQ0LgHOV
 +RRmKKXVixRZPTdtBXQEKQ2i4T1BqNCk=; b=MBd7HXnmcUV5tlUZ0fiFNF/ntvS
 OsODQlRIy7kLFF3ejYV8ODVW7CfVk1O3hglWiXVsP3YtvWFB1akFJbXzjcJLtPNs
 Yp0AYnCeA0NBbUYWrCRhwUDaaURyyMhL3Gjc3l/xm8sgl+2PnGuZ+h4yrYCtd3HS
 2agzJcz/NFYABsIUI7CJLZzfuml6v7IS3vW4pkPxd/GPnFDy5xIFyTcqZp/Zw/a3
 PWCj2iM1Pv2/DxIIIgNbgd65eP7+vF8RKn+gLYip0Cktv60PA4X3rw8d+M4XYZj3
 tCBcp3jNVJOUVQ9S/9R3pcg4Y/731FypK6LjW/OuDyYFPIoi44GIgUWtCnA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74tbg6e3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 18:13:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e617b5e9b3so96685ad.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791569638; x=1792174438;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b7PCQ0LgHOV+RRmKKXVixRZPTdtBXQEKQ2i4T1BqNCk=;
 b=Sr/bQ7uQ+hxXXCzy1dXZXXK/G5FK5DiYgitQibhr212CU9tvC7F2i/QAfPwpkRKwau
 P2IAMPJc4mcvmyQK/ryQ3g0Dg4KQ+kOqZS37JnGlTraFarOTFHL36yqoBfUUxPojZ1DH
 nUbH01OqL1dbLLmQWUh00MWCFRZ6HyLIpsvGgAHyoD0+Vgike8qhlrQpuZvIEzy8iWxk
 lSp3VXE/E4xF02xL0uxj+cqgVxqjna18jRtSvhVOmWRnlni2FnRAPtJcyXzqC/gIDkla
 NkVT3jE3WjaY94mwfctSK7erLMLk+2XiIW1xkMKsiegxuKxkUKgV512ZWPrJhTLKBL3b
 VXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791569638; x=1792174438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b7PCQ0LgHOV+RRmKKXVixRZPTdtBXQEKQ2i4T1BqNCk=;
 b=pCnO013UbFQmcxnCZJr5R3OWoobqarfWRCcNU8ZeJ18cZz32ToHEuKYYhGJysMu6vV
 dA0Apx0/G+mVdBtaVXik4Tf49IDemdrTf4QIht8UUfax5sJShPqGTqDImH9eOYuwketq
 y31Sb4SngGK9H4cv+WQ/+3FNNZzL23etkhPLGDRGM9nnP4eMG2Q9UWCI1luD9+nfqK7I
 ZI377Ac8jY1PEwjhxOGdrdgqv/pl9y1oVW+Hl+Yxsj7Ww7KzDAEvQLkFu0e61a6/JloO
 d63qS/b5pQnp+mIYHj8MntjE58mKCT5W5aIOjtXx0q+j2jlJPvKPDWMWqL5nCUJcJqEo
 ivEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5liZuxnc2lTdgjG8emDvYBLlZ9UY6HjKsgtwaMSbZtln7ue/zui8ueETAo9Up3yrtAsdXrU0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJBh5NvmDzXI3zWcE6HcQpcQnS/iUrIeE2XN1goum+z0LytRUo1
 T7zPCgCUomIRbFtK5/l5o09FwlX4ad1gJ8vI/kR5DqwCzZ7d80J6TM282J1lRcl7R2AS9kO6AYy
 S3QvGJwkgBelkxkUmTBmytmyijBpwSU7TUJ9Frcq81tC9Xs5asMb+qw6vcGkPN5JegXG6gJI=
X-Gm-Gg: AYBFou3tRzndupo7V3iRtSCMwy9W3EJ8oebqNz0/fj7tk1gtY9CoJrcK3OzVQb2sWmA
 gQrOzBiS3rqxf5ROPZneU6C3h7t+RDTuhP2BhJynL7ofsvS/ON2WDTZQiv/Cvg1j0SAVkFXYxe/
 6N/YQBx6GnzPWfD6vWVxmGFhkDviCN3RA2FSQxf+txIJF490PGHD+OUsOckCbgAt+zhkYPHhyQZ
 vN2AumJnF6QVMyJKzfT4XfTdLBHzARdru77yOkhXcgMnuBnFHdllxByM2Eha7U2wsGtO9L/u8S4
 2CxYTmjjEJ6F1gm1jYVxbXvdWOjFLjgf9bfQcdC+ci/8ue/Xs+TkBbZKs8EclfvaSww4fGiuWa9
 doljS5G8YhbKhXSe3kz9gYteu1zsRRX88bRFdmo9WID3xy3WQ9KscyeMVUFzDlhaKKSoKNfCpfN
 qnxWZrItwW+7HJpJQrvA==
X-Received: by 2002:a17:902:cf4b:b0:2e6:13b1:e196 with SMTP id
 d9443c01a7336-2e842cea1famr21138985ad.74.1791569638023; 
 Fri, 09 Oct 2026 11:13:58 -0700 (PDT)
X-Received: by 2002:a17:902:cf4b:b0:2e6:13b1:e196 with SMTP id
 d9443c01a7336-2e842cea1famr21138885ad.74.1791569637598; 
 Fri, 09 Oct 2026 11:13:57 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e2aa4sm14599845ad.71.2026.10.09.11.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:13:57 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 alchark@flipper.net, lucienzx159@gmail.com, daniel@makrotopia.org,
 michal.simek@amd.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, Michael.Srba@seznam.cz, jbx6244@gmail.com,
 marcello.bauer@9elements.com, anshuld@ti.com,
 tan.siewert@9elements.com, james.hilliard1@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 4/7] mach-snapdragon: enter fastboot on bootloader
 reboot reason
Date: Fri,  9 Oct 2026 23:42:49 +0530
Message-Id: <20261009181252.2334254-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
References: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RcEFmFtv c=1 sm=1 tr=0 ts=6ac92ee7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=CUHhPrH4PvmLcno32LIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX4KgAgBERwKZB
 T5jk5Vd8xzVf1s9y+/kWaVZFoEMCmQZIRrB01RjaTfT9M+K3GmfzbkiLR9LikSB8OcSY1s7OhlN
 JAfGrsLhl97db90OEse5r1PTPKsLBbT7Xv76EcA31BvCItAWMQrXFfoAQMPhUno9mOzfhETATqq
 RVSfCkCFP5OMLVBVqyL9iPCzuS+IaakM70rAxSRkpObitVry3TcmQM9ttAzrQ43aMjg0yKxY8/4
 swzX7u7OUVeGqH886gUl9fI4pH242QqLlpGRLhMlZpboMXQ1/H1wfdtXWg8ZSoyg6wytzbDISXX
 ylhBCbwNfIW9mPqUYNx/tlo66HiVenzUHBF90M/AWjRjslF8LNoqCIxH0waJYpkc7sGiGdwc0Ok
 l4JUlNEoR0H4fTWcGKBCI+HBXYZ8Wgb0aQvRtgK7r0QTsoKuFWB8vbR7XaGn12EToCkgIuAfL+x
 t5k+GzBcVdUKrXZk2Fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX4XH2QbrNbiMd
 xAp+IR0S/4g1GWOBlKcn2DF34K6s/rcOVpRZr1XocTxWVX8W1cAmheVCM98/FTtGOTJtynBJBAW
 qJaQxnC05PaNtOUFjFY2/b0Dd7UPZxQ=
X-Proofpoint-GUID: nuPce8cINQ93MKrdszeS59aG38-8flPw
X-Proofpoint-ORIG-GUID: nuPce8cINQ93MKrdszeS59aG38-8flPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
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

Update preboot to check the reboot-mode environment variable
and automatically enter fastboot mode when the reboot reason
is "bootloader". This enables 'adb reboot bootloader'
functionality on Qualcomm platforms.

The reboot-mode variable is set by the reboot-mode uclass
via EVT_LAST_STAGE_INIT before preboot runs.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/default.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
index dbf6f4e7260..429d71d57f3 100644
--- a/board/qualcomm/default.env
+++ b/board/qualcomm/default.env
@@ -1,7 +1,7 @@
 stdin=serial,button-kbd
 stdout=serial,vidconsole
 stderr=serial,vidconsole
-preboot=scsi scan; usb start
+preboot=scsi scan; usb start; if test "${reboot-mode}" = "bootloader"; then run fastboot; fi
 fastboot=fastboot -l $fastboot_addr_r usb 0
 do_boot=bootefi bootmgr
 bootmenu_0=Boot first available device=run do_boot
-- 
2.34.1

