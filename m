Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0727C98318
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 09:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9D04607A2;
	Sat, 26 Sep 2026 09:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2E6epwbSCqxu; Sat, 26 Sep 2026 09:26:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E73A860629
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790414809;
	b=EK8QKxLtXVWLWlPbRbJFSSHYeXYu9Kcnfun/riXq3wHEg1v3bogRVNrtGVJdHiSs2XX/
	 Ab012D600Ji/QM3qQDgs4bSBU6dHjALuTYxa24klcUlyKe3HmGp0iQwf6f6ytyL0rcMBt
	 fPSXiabwfxDQcgvthK4dYYiP4YdnuNRaBNVc7UDoZmVzA4fWZ9InBJLYIAGSUTChHaLkX
	 lbYry8N3Tz3aVpGR1pDZi3lzijJnjjmztso33vOHnxFD3kCKuFkk2HW1Ti+uDqd1TKppd
	 5Md5B6k8fYP7zM/Ar6rcKQc0eWCl4o4C+UP0Z2XGu4aPKqEusOhx2orDKlq4AsFPwUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790414809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=93z66KyBM1g0EeIYBg6ZZY3Gq4pKdRGr4Un07m22kaM=;
	b=V9rkrD18QVe5RXBaN0y0Mqn83Mu7q616f0Yy+opC9WV50rn7lOpjJxmF+tYUNK6fclBX
	 9tW6u1yZagbMtt7XCItcgXIzkai/OBiTG9WLoVO+VnNkgssr4EttNUztIwjYa/U7AeoEG
	 DNo6DkClQE29MPqlunDxnmvwrvn+hTLlm1gOgWjaWLMWt20ZHDP+Nf/MTSsSgZdTs0cIU
	 RzuOuyVyoT82gvyzTzrZUDB9j2bMv2QhLgSQ+6BSAMw8nJOS/y96T8Va3an0rW9QXZvQI
	 WPRzcLUt/JoGNV0UOMRLYtLKAfZUTYyCWBMY/EOsX9n4+Bzgqpz7vxon8ohxqiDXz7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790414809;
	bh=93z66KyBM1g0EeIYBg6ZZY3Gq4pKdRGr4Un07m22kaM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uOUeUtK1Q2yF+Bned6+8yPHxkyywx7rR/oAFtp40Sac+JD3y4Rm9YJIV/QOCy7G2y
	 M2hQb+CWfBhOfLNm7mP87pMjZNy5P/jn6ZZt0PSntqjLpOfNXlph9/DQyMvWqAfYUL
	 Ul+KNXk6kGfsmhxDOUOuEg2zfjO6fjYOpca1hfncAlFHfGVLA3p5UH6DjgJ1yk9NJz
	 7qap4xZw+KkpMEDcS28PDkKvXSzO1xq8dLCrciUfjMcy6FMI40tF0rA5vyAT4KIxq/
	 EDuCnc8d/nD8WXQVA/oL9RVWKN2D3o4EYvZFrml+FwKx4tRH1O/qP6UaEJT28wwJNW
	 3YXWNdvU+4mJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E73A860629;
	Sat, 26 Sep 2026 09:26:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A32F0329
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 09:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94ABC812E7
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 09:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FLC6OB8Jjbce for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 09:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9667781235
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790414806;
 b=NwCrxSBhMgG9NS9v1nz0VWM4SXObSsUrxoYX5cH/FqqEnMgl2ljfLjq12N1wQ6IPDzh2
 Qxi1RscIn4pSo16z+crwHEyDxX3UTt66id7XlXiTYD8k+5/m9xp162QnOBuHspZELSyGL
 Wr+QzWt8zGxbtF4lkPkiVmKKlBuCewxrbKAVAOxdp06jJiOKXWIkhpM8X50p1dgqRbdWf
 t21Mb2MBV5iMLydxwSU+CiuYJy9SeJnam5jCAxJEiHr7BjY8wXna6Moi0ICwDb4PXBjEm
 KgyoYXNjtrHqPMOry5Wd8sq0Q3yzoHkvqkEr/r5x/7P3sYTxUxLRAUAYQT19mMBJ+Rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790414806;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=93z66KyBM1g0EeIYBg6ZZY3Gq4pKdRGr4Un07m22kaM=;
 b=O4ogpvtNRJ4LvHdTcR4M/FspQ3j45MZcv3UmTtBvt/XhLAii225bRrhDRl0DW9EIIpQG
 7/g2nOditOFp+AKIJAhMpFgvSCbt+VlPZi3vFYrFpe/iW2KuUhtX8dOFuYu3T8V5BtnkV
 KR3o9GQPB4krDsZpgce5itC8b+NYKKncPdE43r12Olb9GY8AVKb2N+DqIL/MwSyudZlmT
 DYfyo1ONL7cpxGR7yd+Qe/borv5NYAv+BPC3OrMNvkEp5E0/InrORoH+2+HT9lCDL4W4f
 B5Nkv68LsuTUPlSlkSreJfUUg20rbnnJ4QlelF+PqiCa4BuXe7yOYfFxJuv6k9H4x1w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=D3047y9E; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QtzpdNzj; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=D3047y9E; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QtzpdNzj
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9667781235
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 09:26:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6OlH13527087
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 09:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=93z66KyBM1g0EeIYBg6ZZY3Gq4pKdRGr4Un
 07m22kaM=; b=D3047y9EtUq+KQwaNL9WTp4YJY+u+lvZ0aeG3jkNy4FH3LhdcgI
 i0BpGdIzPITtWJsdEVK01Ewlu7489B9lKiwC/VbCwatr2EPCRMz1qpbPMuU6PRFD
 Ed3KshEhtbczFY0cCX7gHMgSEzr8EHB+AyGIRC7W5TpAazdOWhK6QX30DYXM05j1
 pn3MIr8L5KYEwCNkWPL3Z7CQzwZkiOOe1inHbsIp3+sZXwX2FXbHvAU1jFEs5RTR
 pCXRuWfyo9DnwUz5rBHAu7aq9CnYk+GxpsxShmtjQjVlkTmW/2S/AJ05iY/eob3o
 tD8wnWWRqGXPSLIuD+zCAQkwOjDxM4X0kMw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx64urkpb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 09:26:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2773212eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790414804; x=1791019604;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=93z66KyBM1g0EeIYBg6ZZY3Gq4pKdRGr4Un07m22kaM=;
 b=QtzpdNzjQSgBZ7vSFkTRbOIad/BH7TkeHsii/n7bRw7mHPcHubdvJojSwMAZuGrAsa
 Gu39GTFydSHehKxWQ1GQoohPxeBYOJFNkpv0j6garFdAfRWvk+oui6tlR9Dyj5VJOH+E
 Xobr1BwLTBtd5YHnzAUzh6Lm3OYX86AxYKXtFISDAVtLo6XU+fc58PtNqiapikb1+1ki
 kyzmAOAzHPhuXHnvM1oEYiROtiD80X7JCf5pKjhe++2eV9hVz2eTz4B3bA1oAlqfB3zQ
 MRxH4/z8f83zgYjSgxEgNRyZXcE9ZvDGgI7j+/HyZhqBXhau+Q6bEnwYFVb9FbMfbGCB
 ePBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790414804; x=1791019604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=93z66KyBM1g0EeIYBg6ZZY3Gq4pKdRGr4Un07m22kaM=;
 b=bE5ePjzuNc3FbFO9HHy03dMBwDJMj0FKExXvhMOgeXW6BWHvKColGYMLqUnUptPslB
 sos+5MFLDK8HL+eSDA4nmSdKU6pU40ODxciCc1DZasjmi7WS/vtsWRMfUsp8GCf3PUxA
 TNjdCx53rAwT/kfI87QOnlJVlTFEWKpWrtiLg4nRNMssa17py5GvbI4GJ8kOAoSIWYMD
 QRyX80UYfw/hmQ9L5t2AXh/nRg42MF2VfmccesoMrC0zE6sgoziPE+h110N/Q+KYuZjv
 86ERSsEB4lu7xYu5sc/LQCWIFQ8oGz38lBDoQXEQF3zfSzBoYnfR8g0Eyrg0gJ+7APXE
 vpPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0FrGw27lqBT7dXOzuwUUHlUn4NfvgOnIoHCwBR7MnbTWhf4203+SdE8UwDRRZouqr6WaqufU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK5CR1Kh/e4H/1ddsICg+TJGHstrygHWe66bmwwmQzal7hafExx
 3SJp4zcaivJpuWPYbwZSSa7hTlWn/M8CFZPmAiyxt5Pq7AQG5xWowjUr91QM9G+EwNdM9ef5vMA
 jfXjTbn+/5CU5bWCquTsj+bT0BFGoE4p2JaJd7K7ajOFBsC+9AtVr+7R6TO7HlWtwT5MzQcE=
X-Gm-Gg: AYBFou29G4fWzqf8t1zTCZM3zNySoEbhC7pF0POvqcs6/3SYtfM6B8WDeqC9+7z9/tX
 14N/9uZ1FlwrfagLWYT9eDjcNJvKNhgqLQyUFkvGDTmu8s7HlPyvtnGN8brKnPsX/81Vi3Lv0bH
 osHOVeGEp7Yb3yq+tReF+RGnx15NGrSszIzY8mJ0NecU+NshuEAP1MF2Peiz7XrpF4NnDbyU82H
 vEAzYl2Qh9uc509y6k1wVfGVr4GN4f0Y2QyM0fAYhPdUxQQsTWEiwwO9b6KuVIoIBRE2SvAnPVt
 v8jYYXR8C6K/1KqIQYl8ztX3GEOvFVrr41b7nRSQ1lQTLeBlpvzWSIOUeKrNwQl8TXe0pxt4JkZ
 b0sZhwWnIuC9CIwLXNffSM8cupjRDCjkVrjSBsZvDQXwSkBzBMEYnf5OgIKJP2z/vc+uNilKR6M
 xgRRBRoXTUZxzfC4aNd8s=
X-Received: by 2002:a05:7300:23cf:b0:33b:e75b:cc42 with SMTP id
 5a478bee46e88-34271d8db46mr3557979eec.19.1790414803013; 
 Sat, 26 Sep 2026 02:26:43 -0700 (PDT)
X-Received: by 2002:a05:7300:23cf:b0:33b:e75b:cc42 with SMTP id
 5a478bee46e88-34271d8db46mr3557899eec.19.1790414801701; 
 Sat, 26 Sep 2026 02:26:41 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34145c17074sm11804608eec.26.2026.09.26.02.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 02:26:41 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 aswin.murugan@oss.qualcomm.com, u-boot@lists.u-boot-project.org
Subject: [PATCH v1] armv8: mmu: sync emergency page table attribute updates
Date: Sat, 26 Sep 2026 14:56:35 +0530
Message-Id: <20260926092635.2712021-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAzNyBTYWx0ZWRfX116MW0Y49Pq2
 LOjh8SxL10wqRR8HXU9Uo2+xg3mnNZhEpplU0C626DxJs71ioZisKKbhjp6ZTFjcC5u7OtHg8Z5
 VX/qAtw3oKSwfyrZ3cJ87t+tmDFquGY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAzNyBTYWx0ZWRfXxy16f3FvbbMz
 EKF8oshcj+nnP/44fYxNf6ftr0+4l+151cIkLJZK7E7cElf7m4Qncrf1+yBcrgXKkSYyzq8zisQ
 4Nt3qGjg4Ab7Ffh+n7N/WThPnhCCY9GG7L0Xy96ABdsMLlCEQ1q4burKk14jRQBswtxrBoJw/qh
 IA6c4fVjoaGHv2OzF+bwif7MNCrI3BpX6RFfj5JWE3Ddhyd7JQJXRQoelLomzTygLWugL2gYeVa
 F4vZMnaa88hRjC6hZ7yqSS+bkrixGtWYTGvBKjP8QpPq/ctMxX2csJbnVcBvpcJEJxEpHRxjm5i
 BDIPUmpBfiUbgvMuba8t26QthfZbKCIW2XIPTCJMJMVjxRgYAJHD2NRtwSrXU5iaaOXfSVDGa+Q
 jien/I7TL1/uk1H5AqQePybfjPvGk+WyxCfIu1Z4QmI1ffks17hovEUEqCCQOct4QZ+iHu5G4TG
 IbLJr/a4Ox3pm3sx+Jw==
X-Proofpoint-ORIG-GUID: So3ooKPt4rINACl-zAs1emj-0sE8BuJD
X-Authority-Analysis: v=2.4 cv=E6xYNqdl c=1 sm=1 tr=0 ts=6ab78fd4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=mJ9KI-YFyavrVCWcsTMA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: So3ooKPt4rINACl-zAs1emj-0sE8BuJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260037
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

mmu_change_region_attr_nobreak() updates only the primary page
table, leaving the emergency page table with stale attributes.
The emergency table is used temporarily while the primary page
table is being updated.

As a result, speculative accesses can reach regions that were
intended to be blocked in the primary table, leading to XPU
violations.

Update both primary and emergency page tables when modifying
region attributes to keep mappings consistent regardless of the
active translation table.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/cpu/armv8/cache_v8.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index ad232435eb2..f351f11007d 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -173,7 +173,7 @@ static int level2shift(int level)
 	return (12 + 9 * (3 - level));
 }
 
-static u64 *find_pte(u64 addr, int level)
+static u64 *find_pte_tbl(u64 *root, u64 addr, int level)
 {
 	int start_level = 0;
 	u64 *pte;
@@ -191,7 +191,7 @@ static u64 *find_pte(u64 addr, int level)
 		return NULL;
 
 	/* Walk through all page table levels to find our PTE */
-	pte = (u64*)gd->arch.tlb_addr;
+	pte = root;
 	for (i = start_level; i < 4; i++) {
 		idx = (addr >> level2shift(i)) & 0x1FF;
 		pte += idx;
@@ -211,6 +211,11 @@ static u64 *find_pte(u64 addr, int level)
 	return NULL;
 }
 
+static u64 *find_pte(u64 addr, int level)
+{
+	return find_pte_tbl((u64 *)gd->arch.tlb_addr, addr, level);
+}
+
 #ifdef CONFIG_CMO_BY_VA_ONLY
 static void __cmo_on_leaves(void (*cmo_fn)(unsigned long, unsigned long),
 			    u64 pte, int level, u64 base)
@@ -998,11 +1003,11 @@ static bool is_aligned(u64 addr, u64 size, u64 align)
 }
 
 /* Use flag to indicate if attrs has more than d-cache attributes */
-static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
+static u64 set_one_region_tbl(u64 *root, u64 start, u64 size, u64 attrs, bool flag, int level)
 {
 	int levelshift = level2shift(level);
 	u64 levelsize = 1ULL << levelshift;
-	u64 *pte = find_pte(start, level);
+	u64 *pte = find_pte_tbl(root, start, level);
 
 	/* Can we can just modify the current level block/page? */
 	if (is_aligned(start, size, levelsize)) {
@@ -1039,7 +1044,7 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 	return 0;
 }
 
-static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
+static void set_regions_tbl(u64 *root, u64 start, u64 size, u64 attrs, bool flag)
 {
 	int level;
 	u64 r;
@@ -1050,7 +1055,7 @@ static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
 	 */
 	while (size > 0) {
 		for (level = 1; level < 4; level++) {
-			r = set_one_region(start, size, attrs, flag, level);
+			r = set_one_region_tbl(root, start, size, attrs, flag, level);
 			if (r) {
 				/* PTE successfully replaced */
 				size -= r;
@@ -1061,6 +1066,11 @@ static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
 	}
 }
 
+static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
+{
+	set_regions_tbl((u64 *)gd->arch.tlb_addr, start, size, attrs, flag);
+}
+
 void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 				     enum dcache_option option)
 {
@@ -1095,6 +1105,13 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
 {
 	set_regions(addr, size, attrs, true);
+
+	/* Apply the same change to the emergency table, keeping it in sync
+	 * with the primary table.
+	 */
+	if (gd->arch.tlb_emerg)
+		set_regions_tbl((u64 *)gd->arch.tlb_emerg, addr, size, attrs, true);
+
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
-- 
2.34.1

