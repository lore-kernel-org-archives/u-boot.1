Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB64C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A67B560BD0;
	Fri, 18 Sep 2026 06:49:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZNxDbNqhktSL; Fri, 18 Sep 2026 06:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0FE3260BC4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789714170;
	b=LxHlzXwgTYDRRUlnbHQP5rgXbsNPX0QT3eHx3qp3+3+XbMMU4RjDnjq5dYlc1HSWPzwd
	 6nmj2cNSa74sUSgn+m0W/WXJV/UMXxILQHo82B61Yb8mur5p5jQ0CTjZT9dH7eOvNnVFV
	 r08PIzL63MBW3SuJ7DlSMNpY6JZYqBX8Z9o+N2D3q0RR9dfsko1JK9aJ/mV08SWqanWba
	 62GaWre19qiN7RGEmJrV/q3TYTn5MLqNMdk704qOPDQESyz6wUCpsaNBkb3SpgbFwmqf/
	 acmYvCpqUg7oDnVHrOIgAwgp0Z735FtH2Lm4clqWJuj6WR1PY6ttLh1cvB2LaquIg3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789714170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/4U5Py4fDGQHGvRABVyXvc2pJRnLL0g1+vJ56MfR/Q0=;
	b=nsjqDIynBWxhXLOnSjwUisXs8JxswR/tNx2m4/FGUXKc80tqPbOfpONtyaRjKYqdoSxk
	 262Qzrb8Is6NWVbRRsEPk+EWA+H8EEqQlZnS2Mo/H7SnBXU5DwLBn74mNm4+sY9aQboHq
	 9yZ4npLWkWgPimW4H4CSWl1ZUIZS2iOb68HDTcDNJnE1FJ9WQ/ShBAml9HLvD+X/VrJ84
	 uWkEvd6U0dGbU9CVld8V5oGyejXIXizkfAVDRTfp34HuQ61yP/NyzGMxKK/sSVg1nhOtC
	 883Wn7uhMmjjxoBIiebhet1et+4h+x5L7SncxA9pqGxUBtYs0apBCrw+9hGCPWAF+ZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789714170;
	bh=/4U5Py4fDGQHGvRABVyXvc2pJRnLL0g1+vJ56MfR/Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PPY2s/pOtBj3svtGMP20uvKSsCB+VTQ8jq0z+qc0PTgZG7vtun38ixHIdjFYpAS5G
	 9md+Nz8R/38tr1PcbPAmgzcsqKb2fjpsgCgB5YoDBRw92FTQWqQOqlbg6pZ6xqNGJp
	 7rf1kOaZa5hVBsSgBVNPypcW98gpisHjUM1RFPbxgmKvTVXQjfaw8LX5Cz4K1Sc4Gm
	 oPf3N6PJmAc85eJwS5+zYp8h3m0O2xYiriGXcwMOd/Wv9/howZk/126AuvMxmIRInJ
	 55Vbw5MH3ecZwyiNVrJXCnKtnj2OBL+0M/BPLf43Uat/e3tmq9EVu9of8uw+p0ktKP
	 U7YDlHnen9HLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FE3260BC4;
	Fri, 18 Sep 2026 06:49:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C4F529B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 525BD404CA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:49:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GDWjCJGX5L9k for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:49:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6AC02400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789714167;
 b=pxk87ChsbNTnXedW5nIYtZTII5P7RUCU/WhqKna6g9pj+e2uT1OWtdZDn1UoiW5nl886
 +gpGIFeMrcp1X5rvFupTq5YyoWdoczFcJzBxCWpOI7Ok+CfN0/2Th9oVeIx/HsEEiKYLL
 VOUR8TrM6GME0Wy38duYT3AjEDcgF9ddhbP5a6DSCooYDMBbgljRwP+G9Y58NJh1Sktb6
 nNA2Us8cp4jCNW27Z2K375uHJLO2J34SqG5oTzY4y9lQXxIgLlIwWWUlSJigI9vWlWmO4
 iBA5hxlluSorR3fQmRp8NqiWF9X9Q2GDoOOcuNcxB9BsrDRNiezfp1u0PNVsoicE1AA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789714167;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=/4U5Py4fDGQHGvRABVyXvc2pJRnLL0g1+vJ56MfR/Q0=;
 b=j3AB6pzOqpcZWClO89RV77IiiHEPATNRj2mVRqcGnzlRPxQO2SEB1zfRUpXpCq8B6wfW
 biXtfs3tGqcGfrmG+J0po+x/4a+WrD4ZjFxFi1kbgNMdKJc1ZtImDP/DMbOJxHvHpPxt/
 mQTcEx6YrbLu4ifVqPr+ihG9JXCItr7Qp1rff2uNQ5r2vjiWDbsFUU6Bzy/TyJdf3z1R4
 3zHFVeyxCj+6gBrxB3DoCJdRGVm9cPQ60zdyb1ZrFX8+0upPovpL+4dDcyK2kA+0I/vFZ
 JDhsGovMifWa39j2sn+kPElHbSjSpxFFo2X51GWcjBiXYM3VcdZOOamem0ggdQTS1Dg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LUz4kLFF; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VUs9JqRU; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LUz4kLFF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VUs9JqRU
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6AC02400CC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:49:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I5xsYG3834560
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/4U5Py4fDGQHGvRABVyXvc2p
 JRnLL0g1+vJ56MfR/Q0=; b=LUz4kLFFhFh6cUHBhKzObVYzFBcJP9nybvNGAkAX
 g/pnUtMbR4Y1ZJ5LXph7uKuEMR7WmH1k8o5mfCxjXyMIYYlftuOgevwqc1S1uYGQ
 uNxo+icnwNTOK7Q/1qGX5IeVojoo2ZjBSwrD832oUPwqtQNkxwIllBdvGzWPObcm
 EmURMARQbgP90k4vd4HIxvk2Urxj0bLclHOkT+1MCt/bggmSw1GbmLeKl0Pf6FaF
 U/+2UkIWokFP+TY4afFexTBHJxf8Wl1OBOb8ocTg4mUCq4x1EsPsrWc1umcVlgGo
 dVQljIKkil41X0NkUkzoLb2/RZt6Ip3RG6htnbjfaGUoQw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gry2brans-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:49:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc52c1b829fso530171a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789714164; x=1790318964;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/4U5Py4fDGQHGvRABVyXvc2pJRnLL0g1+vJ56MfR/Q0=;
 b=VUs9JqRUZ0n06shkojNgkn/Pyciwu7jJGQRFNHQV390VTfZEBt+e90IudARs038DqJ
 ujl3bt0xKR6w9/71TKhi+AvL9Cysq+5j8GSRTi/3CGgQw/7B7XjHTljOo+Ks4maylBMD
 0a6nyx9HfPCP8K5+gx6armsJ6dTOyHr641mb1H5GxUGjCxJ6SLICWekQhuoIWCgTgVwY
 I/4tZQoosS29g/gO+IMemANvY9sR+a5yOot4fBPsGeo0VuXtkf8aWSAIOv/bceXmublU
 D40Hux2fcsDCQUMlV1TSwuJMcJb4p55///JadBaMx+mpc22u8K0n/igEE6lLvk8kJy/R
 TFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789714164; x=1790318964;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/4U5Py4fDGQHGvRABVyXvc2pJRnLL0g1+vJ56MfR/Q0=;
 b=pnZwCjUvsin1fuAbisDI5zz4LDstXGgIgK55qDA3wdlvi+5WSwLtETrKKtG45yiOq3
 kg2oeQTnz8E6QXDuSnMPwHeeWRjQ1/tBK5ZfntRDSKWrf2xt+1Lq/ZQ5b7Njh4lMloKw
 7mCN2mWFOrIVXzrML8H+xd1eox/ESAcKcnNC1EEZ6oCMWG5MMxtSgKjXm9yeG2feKgag
 ig6n5THdzfsBFG5AFHw1y2j2pVTZsg6C8f//Aa4ZBl7Chavw+TnTPYtKZhRG1mK9TEqO
 SboS4D6ViiaBIkiMA00f5VJ7j/R0pvSEHrLt3iaIGJCHTuu/4pElWKHevxJaH5WTLUH3
 9tog==
X-Gm-Message-State: AFuF++kx0rLjI1P4aBSR/2WpcS+qjoD3AKIb8TC/qh7LRgCEyrgIWUGp
 T//aNkVWwqvD0Qf+eAjBwBFP+zFYm+AEqML/VJzoWG+cwBWdhMkVTRlpBvqkvEfypBbivDSTLcq
 QSoLWm4fzQfdfNOGws5LqK/q5jJD8xwxjFqVCZY/pSHSFgdc4ue8513N1nD6Yua6y2VWvfDo=
X-Gm-Gg: AYBFou3dCOj6G4z7hU5VTxm+GoYT5V2gLfiryCC6iR1e1FTBNU/aVlHngF9FF1/nJTF
 MCIXKOSsQEi2iUBxWSAFkrRlzpEI1ezrz08N5XwFUFoRb8VBy0jpiSI182YSjq/EMn7LkDH/66I
 F8vzlTPfkk3+REv10sd8gLk+uIygo+USrB86zBWzGKe1hKYSsIK+efNnKCXMltQIrtXm93sgXUO
 Xft0O/xNNMs1bTAi6g3l9Ugtp++gLOY2YlR181gAAQ/1OKTXCx7y+Ev+6Yby3ww30pvI5NUQkmV
 b0KlrCfFPkZt4AhT6b7qe07ElWVKTb0TYHlUHf95gZbm1WVy5T8jkVRrlvRxXUxhuF3AEQoRyeu
 sGZ+fDlEeGbXPuasgTDbVK9XjwDanbWyurZwNK2XoyqL0cLyxOUzwdzx7KeAa4SXZiuLETBHI+V
 PP+eeTECi1nshqSDilj92Lr9q9Sv9HQA==
X-Received: by 2002:a05:6a21:6f12:b0:3d8:5a37:549c with SMTP id
 adf61e73a8af0-3dd8c3ff75dmr3462731637.7.1789714164502; 
 Thu, 17 Sep 2026 23:49:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f12:b0:3d8:5a37:549c with SMTP id
 adf61e73a8af0-3dd8c3ff75dmr3462677637.7.1789714163958; 
 Thu, 17 Sep 2026 23:49:23 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287b0293sm1943598eec.24.2026.09.17.23.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:49:23 -0700 (PDT)
Date: Fri, 18 Sep 2026 12:19:16 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] fastboot: block: add 'oem set-block-target' command
 and runtime override
Message-ID: <aqze7CdMk/6Qezln@hu-varada-blr.qualcomm.com>
References: <20260917-series2-fastboot-block-target-v2-1-2371f8b15de5@oss.qualcomm.com>
 <aqzdt69oS3Go0gHu@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqzdt69oS3Go0gHu@hu-varada-blr.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA5MSBTYWx0ZWRfX2D0YsfHMgJ3p
 7IoZaG4smvqFFevimoFXJdg93KzPok5oDwf3Vts4axqKhnqnd01RFg8fYJyp5op0WZZlEKoDokI
 ZXbPA0RyQuO9RHcOtHNFSd0R03RXWUs+hd2tLekFUILELgMpb/UyZJxSGtBTuL+Krr0keM3//cc
 VOvancxH3Jh7dMstJSOd8uRwzkxUTFfx+kJE8z40Rrc6eTHP0FCJjbDgYTQlvpWwD1EhfqRz5l8
 G6stAVHE1BwE2xwctOWUobU7DUOJC7M8QNqUq6pYlWhvZlp/GCJzf5XY/GuQOM7yXUy+3MQ2VSy
 O2hm0O7HKgr1SDGEll4pdig1cVjLxqI+tyoS4gaj7/j0hQK8yQ5ZKjTN+7+U9HUMdxG/yPtgMvL
 ND10P0IlD5U8T/f+BOeCaBadnxD+7Iah9yVXZzwy4gDtSaso+v5M/wq83eOM76fEsXyHDZYHmDL
 wEwlYeFO+2wSTNMI7Iw==
X-Proofpoint-GUID: YJliwk2jIeMTvqReQfAky7kYTYp5ksni
X-Authority-Analysis: v=2.4 cv=bYP+w+PB c=1 sm=1 tr=0 ts=6aacdef5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=apn0q0EWAAAA:20 a=4EMKCD8rKdI-x3EeEIAA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA5MSBTYWx0ZWRfX4+i0vwX5P+d/
 z50hTV3H9OAaVV8Dd+HpzbdhkjRrpNBZ8cKHjzobYdoyu2pinOIS2o/um2AqaoALq1UoAsTU97S
 h8PkekJkneQU/DXfUWb7hZgVTtB9w/w=
X-Proofpoint-ORIG-GUID: YJliwk2jIeMTvqReQfAky7kYTYp5ksni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180091
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

On Fri, Sep 18, 2026 at 12:14:15PM +0530, Varadarajan Narayanan wrote:
> [...]
>
> > +static const char *fb_block_interface(void)
> > +{
> > +	if (block_interface_override[0])
> > +		return block_interface_override;
> > +
> > +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> > +				  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
> > +}
> > +
> > +/**
> > + * fb_block_device() - Resolve the block device number to use
> > + *
> > + * Returns the runtime override set via fastboot_block_set_target() if one
> > + * is active, otherwise falls back to the build-time config default.
> > + */
> > +static int fb_block_device(void)
> > +{
> > +	if (block_device_override >= 0)
> > +		return block_device_override;
> > +
> > +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> > +				  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> > +}
>
> This config_opt_enabled check is not needed. drivers/fastboot/fb_block.c is
> built only when CONFIG_FASTBOOT_FLASH_BLOCK is enabled. See
> https://github.com/u-boot/u-boot/blob/211de43d0f954a00a490220c1aac9db298287c40/drivers/fastboot/Makefile#L6
>
> Just returning CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME or
> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID would suffice.

Ignore this, didn't see your previous response.

Thanks
Varada
