Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F034CA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C668980D1C;
	Mon, 12 Oct 2026 05:35:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KD2K8BiKH9Sy; Mon, 12 Oct 2026 05:35:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0012A80D09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783317;
	b=jwVX2C1/rp7P/HSguPw5MNcqoDYclqg8tLg2Q42SNN1a/CAkt+615/U0YpvB5c1MZmr2
	 JtZs4zL2C0LUYFs4lwx2a1OcTK0SnBDVRrZ5s5zggLyHqUuOyLoAoH6UdYVNZwcRTDaZt
	 ruBRluXz5x+nn37P4TqjrdxKdgR1RXJFqPUGEbQd5Y7ipfZGnj50xgjaGoZbmtitJlSvB
	 zjKLVb+U4s0nK1Xkr9GvmWPn1TALgsj32hY1P6d0rrglMfRn5QxHHIf3TQERLaWVq2p7A
	 zzNKJw3yUD4MQkbtKYYIx4W2BT+yLwN+wIPd8+1k3Om/rmGEBxru0zeBqVGEzrrNg4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
	b=U9awlsmY7DTOc4XnLnNK9FBZqCJkzpPkLkHV3MbVatRO2C50myzhG0cFKfAF61vZv31h
	 iZArRF9ZGk9EdtesFdjIyuoSwdqM3fY/1qIliSGtIhNZt7Dq0S1lUnG4nrf+mKiBirkXE
	 pgnqiUtO+glnv5X2J3eLUG0DSYLMiemE5fiINet0JriBA5iodT3LLP+mdk4n553MnaYyT
	 oDwDPOqz37BljzcQS+wXeIqXrowtnChdAKBPaC/69x0rwi1vpg802ZhL8gF4bQe6Mpgeb
	 pYhJ4Xh1LMOao+p8u+PdFrunKxTFKJjZyNdVGn70qT7kwZZKc5zEkMbbrnhL0rTxCPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783317;
	bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IxK2SudcKFRVgvQjtUyOCEnx+emmCEoIIUv4hNPGXbC3Mj2J5q6tIxiCjyX1LB2C0
	 GtsyvifmPwiDZIPf21e5TfR8Xeo1KdZQ3XyZrXe7jWGSDbnfj33p02zDjUfalbFUVp
	 t/14yn57GNMXSFyI0KxLOQ6rsCNioltmaC+MgW7h5o7fMB5icvhlonBIIV6H4YzOKm
	 AtbIohXv3FAEpyOrPobDDUVLpZ6VE2+FMTzxMAqDOtJTMve7z5AcNO/MnIrrHyCyIm
	 ZF8eUYyGx9PBnx1Iix0VZmKOKooT6NlbBzpwee8wZI9oXJbnKzM/7yeAWnd0QILmcx
	 A+6zd6IVCJ3dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0012A80D09;
	Mon, 12 Oct 2026 05:35:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF90D1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B553D405F6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FbOJC64gnLtn for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C5A8405F3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783305;
 b=e/8hIjTov/ijo1X2qO75kEkgn2/VweMQZxkzmWKCfP4pKfA9Vb/vNPjliiDDtBPY0Itw
 9fOaJ97p5eEUZxAr4H98dUaqT+NG7uW30THRHHPIcV60ae4oXECZ5MvVTX5X0bE/cSjJg
 tITupBX6zKWu1YhScaXp34uVnhvQXHP5xjl43z1omsmrFYzBfpY0h0clPU1lp4n4FAU5/
 8onELd75oKW5DfQjOa0dRzFTlu0nGlRBdBYCEGEZ5InDWq7DlmcrQpy9a/yvZGvpQ/XlL
 W8OkVv+BYD0uhD6UfXzktKCxKs15W5a/hIeXohKQt2TQwkjaliltb24siPPTfzPoucQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783305;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
 b=nIe6U0pKvxYdn5Vr76FGB+tGsoFhTG/gpqJunhnJD7PqAgkr+x76pyjGutOMG2cpLgIR
 bp+Buw8qJ1W3WnDzvlfXm2F/yUtEzlkmKl4Xxwoz2Byor08vIG6jo4twHYdAOQ+FE1gg4
 9+uxLYhFYu0Uf/s99F+mazeMqFtY+vjGgb85+yC4GkpvqPjSXYIwfLwtnseRAU0ZkbqHI
 QYb5mM1yZ3NP0OHP/AFcqJmRoel1LJW07yxy1KP+5TugBwUFTfa0nFoWChG1YlT3C0crx
 IPtfnePUEvjsR37P/BdxLLoyD6PVuVliyqwutY9Fvs9IIfXNgIEWC99L9ovd6gk2w/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=H4Iyicbl; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PiZSth0J; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=H4Iyicbl; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PiZSth0J
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C5A8405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55kNT1856967
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=z5BPJHKdvnG
 eLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=; b=H4IyicblurBkxKnNSQOiYv/Lowg
 qvq7oupS/C2vRxzHcV/Op+bu/rV/4xyRYyLUpLDayHizvjBZ3L/m/pf1ZIKSt2qt
 pfOZJlDt2JqDieGxTlTOmg9YQOI7mYDld8sSoMr3wH9vEESXCa9v4cbPdTg+CR3R
 nnzU68gPM6PP1fjf5tg5Y7N0qb7IwnotCtVdGo0TC177j9SX8ZGwYk5yroX4Bnif
 FexNGeQ2U1OgDRgxmdgmERXJffBhnVS6TB8D8/OBcCYVc5+iWeKkoFqWjBdZUqQX
 d+0M3tK85tVrnY2bd2bLZmZxiMVMjzImDlhcLLqg04QyorQGVRrwXnmtTGw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cxxn0e0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso2537875eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783303; x=1792388103;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
 b=PiZSth0JyqHhbsv8fhEhZ5kOi0DPRgHFMWZbYoR5Xjudd40EDGRzfhAI9vkAPkVWPS
 iHGcPa2IMTi3aYr+NoUvDeQOCTGG4uiGZmk8sVBg26K2AVXtJIQC6jQL9C3G1NryUdNs
 aW2LJ+bTj+Bs4PDFxJkrC4TyaOW8bqhX7+3aWQiR7oiyrQJ98zwsvt+KhJJDsp2RG7Qh
 5Kdt0ypkSaHu+OflPFIfOSegZKLKHALlUXZj4syWnoY3exDwFJ8Jhy6s0PVBERxQ4ZUY
 MQmK2DzBPxPmwrUgT9UqcbvSl9R82yDET9KIeSOdXgkNR+E27KBEXzsGCvtxfsQbA3Co
 KFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783303; x=1792388103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z5BPJHKdvnGeLYuf0w6OlbQD5a7iAzLTLWiz/TGDI+0=;
 b=q1mJ4MLxBBQyxoj5lhXwDQ8rESyMJA8dEi47VhN5LADrl5jSzPdP/8bJiwHXcJBN16
 sh/ET5tlCFRLchMfouOuqHXQn8ta3JxZcACH3uIDrk+HhPW1ku7Y0Yyx2EyEoMhFR/Q/
 NSxHa2eHxzphmcSM2iFcZU3Bfvvi7PqShns5F4yBZuAlGAxkLFwzkepABHZCD0X8l6O6
 E84Dq7kEg95b0YNZuoSKLd536A4X8rDAADpjkLG12l5pzLFaUP9mhJ/fQgu9iPwZ1ulD
 LMRyHid+jRsckHd8269AvazoAIGNTBN4jvohcsOSImGLWwwge8A7v8fBaCj13x0kQ0EO
 8ofA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwO6+TJVNQNn+uleFNBcIOBcUL6VtTvhO+zAdWutVn2gqeMc6irYAmECgQfXSoxJXvjFuPpxhU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKfOxWsUao0D9WGhscTWVFh+naK5o2iMz6my6WX3KjW7sfyWnVD
 KvEy6319pTUhAwZirQKFweka0CT4ALjPW0sSUFn3rgZI2UlELLs25zK9kIGqrhW7xdi5BO8gj3i
 I8F9+H1Zjs6B9I0fH7D4BCAiCwQjmNq9RqjNXNPKRmygVY5ilSLdohOukb6wjehl6up/6K+g=
X-Gm-Gg: AYBFou0VlxtXrpCFBdmNGwzeOKzfm0wgKJDSkA8adYDyLmCSrLeVALmMADAUO/xrPj6
 MAsBD/KCx5yUkS6DrT6+3ePyxqSPM5TNBCJ16EeDnDU556S/G+5eMgB/SzoYEVwj0pZCeWMr8mL
 9Zfev+aAWd9vbNXTkiPUIcilYGtSP27FFyePgyDNx94OjYiF7EuYCOKs8LW7E5qtpwymfIv44bD
 e2J1KF9CbgqmdvCXeN1/QJF+FF/95skJRo+opySw6MGo6pw/ztHnBCc+4+HMhjLc8DGaALGvevo
 wyOEOwU9ryxIcu8SCqo4kZlzqqlcabo6QD/eO1TXa+L4knTDGA0bhJxvyjHbhDr6SdUCTGxWYVt
 XqtCZZoT+RfI7oUIwuSHJ3bZlvaxnc7WFph6ZZ+WzLHBkz/t6
X-Received: by 2002:a05:7300:c019:10b0:35b:58d1:edcd with SMTP id
 5a478bee46e88-35b58d2109fmr586349eec.33.1791783302613; 
 Sun, 11 Oct 2026 22:35:02 -0700 (PDT)
X-Received: by 2002:a05:7300:c019:10b0:35b:58d1:edcd with SMTP id
 5a478bee46e88-35b58d2109fmr586313eec.33.1791783302089; 
 Sun, 11 Oct 2026 22:35:02 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:01 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 05/13] arm: dts: shikra: retain QUP SPL dependencies
Date: Sun, 11 Oct 2026 22:34:44 -0700
Message-Id: <20261012053452.1567885-6-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NFQBjlJtBs4E3F2KQi4xui1NFS_0JDC2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfXwSp+UCjwUKUs
 lMsuKSzEF3261mIGqjdWa1lavkktIsK0rq5/gHE/sKBByRkCS7hMozqYVtOSj8vfL/JSqydqWur
 5J/D/trSYf/WUc14XhxcEJGZxq4xQh0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfXwC4J5WUzV5rz
 iJkBmkh9HnfcpjGlu92DwksvfM3U0mcLxyj33GqkqOIAWJjTVuGA/fX0wVn+G5rnWkLbiOTkx52
 CwHXy3Poh03eq0B0z9z9/a7VbqjXBV8M9gbye28STA6WA4Vya9gDKmnyJzJISarDaoHDBdSGNYu
 1c8CbDLRubsDdfTsOpvxh55OqBJe3hXUOSEXlVEx5d40ILhFkh+RFMasMeLTqu0gvBkTn7JXb93
 Shtv1JP/zqIgEFAOQUJgcKgxU3bMYyGX772A0T/yNR6jDkGjclu7RKRLY2KxFF1QFZ0GpCB33iN
 b7L+lkbm9glgHus05vS49N/NtZS168YD6E93/XNLXGahVbobKTVmzMsIkES5HdBazOl0x5pHnN1
 11qTXy5dJMkkM3ZsGnBj9p5maHif/Da8glArinP7TGsYTcuG+wTvGU4wFpBY9+FBYabBQvcbooo
 tIbhrICgO6DpcXULlKA==
X-Authority-Analysis: v=2.4 cv=AsJ7T+9P c=1 sm=1 tr=0 ts=6acc7187 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=mHJ2qds8thx7DnZp6SoA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: NFQBjlJtBs4E3F2KQi4xui1NFS_0JDC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120022
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

Retain QUP, console, pinctrl, clock, power-domain, RPM,
and MMC dependencies in the SPL device tree so the firmware
loader can use the boot medium once probed in SPL.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index e807b91ef1f..e8831da6aa7 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -20,3 +20,47 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/*
+ * Keep SPL console and QUP dependencies.
+ */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
\ No newline at end of file
-- 
2.34.1

