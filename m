Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E992C79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 12:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33AF2605EB;
	Sun,  6 Sep 2026 12:18:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vr78A1XvEvTz; Sun,  6 Sep 2026 12:18:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8DF7660616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788697104;
	b=qVqX6CzqderavWLu5FrzVSfWqaFArZI12Bxhd/HhTS+h25iZaw9bOTRWWTQaDqeDNHRb
	 6celVX92sdc2lPmaFuhpb4+zuJSeNIpq9g7LGdGYl2gfzLh7jxDixW0yRXsc1ttzt4J8h
	 zTfr79QOKlMNg51MI/WrbXkHVyrsatAAnAhF52t11MI3T95v0ImzHiPmpn++KUyFJnxlF
	 4pDFFx35fkAPWoaVHhz9p1FvvIRVtjh7xy1TV5HzrGQ94DQC4+RIkg38BJeC4KDyPwm3e
	 8nU7GPYGtPiaziwTa+BosyuB7Cg0sL4BOFRC0qh+DHO4bPASIxOm98LjgVdSJcjQlcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788697104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
	b=DCLq9J5dIEv4Qhal9hfYH7tps+vd94tYyBfNQb6TUEQTOj68A0xMkoRzfzXvEmebkZ/M
	 YDm62yXUCzrqydFZk2eLkll0MilxTglkIyIF852kbT5wI1vD1suah5H0H166GMkIXwEH0
	 sZPISQSaPGFMizWLYS9SZUptoesgFmgNWRasImDgnqOkfwum6RqtZnr8qhywvQGMNAvG5
	 S7KFQRODca+GCD/NOxYUPiJ+rxfiBFOKXBk+V+AreBsMwV6d5caEH9MMUqwp4ywkFp7Z8
	 5+4SuGKR07KHgbCjGT4IveHboHc7wFBhdoZMdLmcLu0GW4XL9JfrbNrPYTzHaJn9QJA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWkfED7c;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="i1NDRu/i";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788697104;
	bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ginF8dEwC/9fEqjf/5TPhfiQhYKWokBlc++SeM+RECYQDyPXOIAiBP5KnTRFT0DA2
	 6BE/JfoiZ/QuNVNcNIU5kJN/Bxv6gbuaCzSsl3enU81pR4mBakkBr5z+CCzUusDEjF
	 raR9PfY6EYf+V0QZR7AeAMNu6PVldSPXbn3ZQaEBtOQOE1zQYWdqKa9H/rI+S9Sks2
	 emWqs0qbwZ1JLj5noi4wg648+B1PBwOieg5gO2924Swb7Q/jC2NDQ8U+dSTjhMEjaY
	 qTKK+vw+3CPo/t3QgEW7vOiendSdtW3ZlKFNhwwMUYpLPdNMOH36WnSpCagdZXptvD
	 7UDWNqcvb/VoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DF7660616;
	Sun,  6 Sep 2026 12:18:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A96E9230
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B50660616
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHAJE3NcIFtn for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 12:18:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A5F49605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788697103;
 b=gHJZI85bCRzyDz7e7yjQIWACvFeaGkaqtqLjjK6K8KGwCklHpC5Ejwf4XW9yqrvMmOlt
 8aK5c9YjnW2IPVmzteKp1Kqh7uYsJ+JwU26gyKedm0SBb1LKkbhfw3zyNCSdlgY1hjJdt
 dVKIBwIx/zn9+QIvLsbEJpzs6GN7Iez5C0BRyCZBoIDbegC06SE37RGFkVJCisp3laMwJ
 1U40PUe/t8MiksSJxj9qIqeE82+oQjLLCrBY6sbDMfmd+vKquH+2i6Pr4uPwQYVLhQoTL
 ba+PJrHUGudZvG6xm/m/hJHZu0domSbg9x7Pz5fQBLNMMDSfvnJ1T72RfD4rxAnjNeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788697103;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
 b=g8zLfpQ+NbM1Kv2IQ/pC15SBxLNny57q8QAKwzCbQoI4B7oUnSDj3vLsF/r8WXzazJJ+
 3VM9W3oNVKE28Kbrrxy2Sm9Wl0U4mJOyayXJPtFEqWDv4Olb/geLvucxNm9BYVkXlEewW
 tLKaoWwX4tOp2MnwMDQIWpr/q9WTdWsQKwNPZLuub8YYB/gkL5VyE6Abv6ZAJnzkwrQln
 Sx6OBUGEOmOF+diM1dlZ/eZzoyaoSdCQ+06rigwXsCrB808EKkrhakD5uwb46GBa/Lyok
 vpZKoE+GzZGW7YQGJ0qpnCmQNp2HpUXiBCOIh3ix2HutfAY4LULNCvj9e4aOIpfmBoA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=YWkfED7c; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="i1NDRu/i"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=YWkfED7c; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i1NDRu/i
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5F49605EB
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:22 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685NxFR2680046
 for <u-boot@lists.u-boot-project.org>; Sun, 6 Sep 2026 12:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KdZW2sS1n6n
 C7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=; b=YWkfED7c8mhNhhecY2WUH76eYvU
 cmWmAJAYgyw8KJx6Q3AIFAeLJUkarlbyAPRLCBJYtORBjr7bCz8h7+rdmz+MHhiy
 NV0JY/kMmqa8I072iCQjqKIWMoaK9z/mSwA2angTs2xpfcgKb/v9aAgzulCBYjsV
 XY0l1I9calwVb1JlXS1XLN4ACnFnXYXZoIImO3Q/JakvgnLXzdeA8lSbdM4JdMRW
 w514D8imLmyS7EW+BjnrG4KwyC0CPetZ85/jLAqCvY0bw5ZWhTRi8wapMuxDEo0b
 K8hZ1uNm1lCL9YoJxFlg2GgYeWpOZ/cHCEQ2ZP4qCy99ahqjbbgmZyCtw1A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8sd3vjs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 12:18:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398d7e0f3b4so3294433a91.3
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788697101; x=1789301901;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
 b=i1NDRu/i+3TcAHB2LeSeZocrCr/t20qNlvtsr36Y2LVduIQvbSrPiu4F7KWEGFhJQe
 HOxoV/tmjAsdf82KiW569LxuKnRqSJaCqumHaRtSlRR+E2SQrD7K0GWAwe71iZLmPERq
 EC5GJ6Ur+o7TpTq1dQ3J1ImB3VkJ56To2a5EGL80NKsC+ln7a0d227H4MW1258WUOWsV
 qy4EgmeINV+1/q/dPP6Hrh9zxyJgiwNrU+U6Mm73NVj9O1wXHIAKVs7MYJGIZhxv98d1
 fLKNYhn2xlvLL7kxjsKzrNdbwbFIonRBH0B+3XSAl21IejDyxBBoTOcIJ2BHgkedOBt9
 j2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788697101; x=1789301901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KdZW2sS1n6nC7X1aep99gBzJm3Ag8EMp9i70MUjuJXM=;
 b=oeAkj1Nv45jlyyh2wjCKvRSthVj7N0ooEC/h3zowFwICoVbWA2tx3snb5k24xfwaJV
 B65yYdS4mDlrNPsCCt2iC9UIDuHsc2xgadIed84WXfdYc+C1IaANKWHbcPn21lGPSMDG
 LTVbMTahNCFayeDuRrQr4f3iCTYsHCvkXHgopg3Z9faIaIbbqGZiVfR/nzNUf8ddr+YK
 FPUAbeFTEzpxG9djkd/dHEV68PezpimnF6ygcsoO2R6RT3G1lPMv5e4cq7isi4/xenPr
 ZkzlDNhZSugWEfaZbIWUU6Hq10E7WlKWPSKDeMs15EsSytNYjbAQDXpcL73MkCjywXa4
 l+wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwP02mUw5YLM89L7nKX2W7DLmkNx6dJMFzHisj3AvyNTiwIVECDTd+hjtqiMo699yfiXz0JG1Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k5S0lbsj9zzj82DCy1Blg6KSXdWCoKOwE6JgvYuxDc2nYBxcIp
 emIICu8LZ2krz6xAwyPCeqnbhhIZXYfpeBGQrHluYVvDu+zly8abyEqsKkxNDfmEYwWyfKYGEJF
 VSyGxTv7Wf3bw9GNE4Ro98roHSLvcUE6yW7MuW4nymj9mlEASEeIZUBvBdauEx9bNEmlEMHc=
X-Gm-Gg: AYBFou16w9YkWE/AITsJ8tUxaCNPzmH4IOwovdHVTocJAeYuVzE03xLO/vEPGoyiuCT
 zjs2zKYcUzJW9D0KDHkZMTxk0k/BU3daP4XynB99sn7btrOgFrpVoxOQ/vICqj/+/DU/+wCDez4
 GFSIrx1DAwMvCAf9Y/qMwiwRh+Y7IPTTsPLJWhsTf5ASy7k8rXX7XKKcB4JuUAb1YxU9kIZDr3G
 6bbzROJ4flyTIURpTbQ1UyCYKfey0rwRyN6gui/q62UujCHMpFEme4TnJOStsP1+Nlex4tegBkk
 PHHl/DuOZvQ/Rn7l2TGqbog37wfDDhArANjUTQE6MbJ/L4OYxsweaJVgWkD94VveLcLn42jqp7X
 ANd5WeTGHb0BbxHOdMZZkHsEchtweTcjQIeKFcg9p1RTSb4yyK1KJbxoNbus/3INF1TQQ0Sk4OA
 4CZdgdKIIxuIaqBUuv8z4=
X-Received: by 2002:a17:90b:2b8c:b0:398:9be6:f995 with SMTP id
 98e67ed59e1d1-39b262aaf48mr28615302a91.20.1788697101201; 
 Sun, 06 Sep 2026 05:18:21 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8c:b0:398:9be6:f995 with SMTP id
 98e67ed59e1d1-39b262aaf48mr28615251a91.20.1788697100705; 
 Sun, 06 Sep 2026 05:18:20 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14332405e92sm11768639c88.8.2026.09.06.05.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 05:18:20 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, balaji.selvanathan@oss.qualcomm.com,
 dlechner@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 4/4] mach-snapdragon: rescan only newly added SCSI devices
 for capsule update
Date: Sun,  6 Sep 2026 17:47:51 +0530
Message-Id: <20260906121751.3550628-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
References: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fFv6AhqkHAUswBjid6rERzRpiEuDoK0z
X-Proofpoint-ORIG-GUID: fFv6AhqkHAUswBjid6rERzRpiEuDoK0z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfX6p0NTCiM15UM
 dCpeIPQaxrmpzfej5l6bC4INP+y3HxxNFS9XMY44XQwcLMb0pVE+wOA3wfarAD4rYs+UgiAvqME
 WcVDYKAfZSnWkUexJloJ/CPM3Q40dJY=
X-Authority-Analysis: v=2.4 cv=dfmwG3Xe c=1 sm=1 tr=0 ts=6a9d5a0d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Xv2cfri5XwcvWjDntoIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfX0ehvvP3sgHkE
 lH0eg5HJWm/+Y/VWL2C0YEElHhCJ+3RPHoewYsn75qYrdrEK4wn6RCstMuEWouU31v+gI+0L1wq
 3WGxoaH4BcbYwp1YSc9p6kD8PFUDqQxeGr2p3xxV9pBdDbEtCZ619dsADHox3CT1G8+0bH0olx9
 g+qPZxUc5J8KtiHX3mAvyPfNsiDJfh9bkroFB+AsL0swUG6k/n8LVUQ2RTykS2Rc1OMHh+7AFow
 b2q51EVoLtYejP/7VhUTmk5U3f8F4cN4CQi1XSoxlxBGx+yr9riawxSaH7WqNs3dEXyFZ3gPxhB
 sel9CphgvMpcl1Y8aKFp8UK91xV5o205d86TrjvTNWXIZLdaVEvgZrduqeWpuDCtlF2ckj1gF2d
 Fqw1dZbH3gkVDBx8BshOKhZWb1PzBPEKsLOXge2jNtMbQR2V1dNU91VHJ2PlMy5rYYbIBU7Z7La
 n6z+dIfjoNXIyETJtMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060136
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

Capsule update may miss newly attached SCSI storage when SCSI has
already been scanned earlier in boot.

Use scsi_scan_new() to detect newly added devices while avoiding
rescanning controllers that already have enumerated block devices.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/capsule_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index 586682434b7..353969a3cc0 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -298,7 +298,7 @@ void qcom_configure_capsule_updates(void)
 
 	if (IS_ENABLED(CONFIG_SCSI)) {
 		/* Scan for SCSI devices */
-		ret = scsi_scan(false);
+		ret = scsi_scan_new(false);
 		if (ret) {
 			debug("Failed to scan SCSI devices: %d\n", ret);
 			return;
-- 
2.34.1

