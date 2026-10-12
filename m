Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E41CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91791606E9;
	Mon, 12 Oct 2026 17:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzA2dEmQG2Iq; Mon, 12 Oct 2026 17:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D59960600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824612;
	b=d0o+HHUib1cOIn/CgeHQyLPYcT726LjeMLHKJ+1TUqKwg8pMMxWop7mV3UnIOqp2zRdM
	 pTSIswe3DLSja6OY74/jdkPwHc7/bUthxFffIoWUdDRin1pPB/TwsMyBwDgdHCKHAy461
	 5kjq8cXtkilbppXX15zeO+d32eNCYHhJzk1kKRfEI6dUMf4uWbNwD4HB0EHM/I/Pu9mrn
	 M3Exz778gYNREuQCpXWhRSUepHQ1+WvPGD4KqhGyTRMGBlMm7t0CxRD5YHWrPE6XrVdzE
	 BIBbCQc16nh/NX+jWg/TwdXdSpEzUhZvoUOIY8fp4LXPvECUWRog70u40QO9TwNIS0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791824612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+uT8Hv72MCHCKI1bzBwi/Yg9bJ3nP+ifvyHANhwZHyw=;
	b=aP0D124MUyOYAo5w+rXmYYGXoTETodW6JhTq3V+qaF/7ubZziMqStAX4uRO6HgiPuAm6
	 mqsun08nvIbQZzQmM1F/1LZ1V1qBxs+hl9o14OvdGPT24+AaeVylqxb9ZA/uY4Tk28oSQ
	 WtFX6q7gMBXr4dheDwzmCEbIiOX/2OaY0hqnIXYfOuJXrjeNn3fzWJURueoXmigre5ZQ1
	 dbUiHwjDYIrhsUgfAYVwbI9i8jkDUez/VIHccI4NUL/Lh4gaF3MHMHN4wvHEueF3AXR4a
	 QIyifBPvfT26LRh30GwBhn7pFicLZDI5P//OBfcX+ivdieiJo1mdgVSJeXB5pnNGHHQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SIZxcgyD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W6r+Ixn5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791824612;
	bh=+uT8Hv72MCHCKI1bzBwi/Yg9bJ3nP+ifvyHANhwZHyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ri4TJ2Ac8a/KgqFQ3XbIvtPT8OXwUX8tD4xIBRiuIhlddHQrAXPw3XosadTcAVqOK
	 Ne8GsJTEJToejstSgTlwx+BLfasq+S18TOof0c5v6dzzCf+q0Lrim14mfqaUyJgbK2
	 ILFT50f9o+IbCvT8QrJn9P6uAhQRBffrpQntFNIjeb22CBnCoCAnMqBnaT3H5b/298
	 y/9tozSriBfEwkkm6wbz6pPxnWdokTcDVqaWMfn/FFkbyiGBIBmhconbMfnntyKhpO
	 pkElZwB3L2QPypccXLqzOjAOdLvHR2Kt5fUxr3Da4X/MY9XbuYCsMnDivhdB4MUtDq
	 yVlX8SCXiRYbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D59960600;
	Mon, 12 Oct 2026 17:03:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 330349CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 249F4606A7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AehaAroaqick for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5D4060600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824610;
 b=Znjh5iRds4zG0ME1vGYYgfSe02H/xEToqcsCiPgK+zreajZFYogmT+S7hL5HIGLONYEb
 ztnpOI8PS7+TajYhX8soFeW2IADLjkJzD5PUw3uHp5ldbiG6L27DRGRGjwqCbs1UeFK8i
 fNZ41gA88Xk7zbyYb9ogfmJ56iejnJqVhzOO8ksG2zD+ri0Ode20fiFg9jHwHlC6wl7h9
 v6nalAeLAiwBOEkEqLp5uisXOF0kSfHqKwkSdJ8FRkPzNdaStUL5Awzz8Z01czeqIMEWD
 fcDMmqC0vq5kPZHmJ/qnxjcORRHAkHqLubYRUE3+d00yqikS8+NXa3PAyDqCfEUXIxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791824610;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+uT8Hv72MCHCKI1bzBwi/Yg9bJ3nP+ifvyHANhwZHyw=;
 b=jBZns5KDeG7jhE+OkiAIs0OJEDFsGp6ARFE38Q6bTT3OtuiQI6qhFmzlOMAFEdEvSPh9
 PQJzkXs9Fp9jXFoejfhWAbm6KYtQ5ww9LHcC8JU5ibvlkeKQVdfJZFNLvbXG7fpBuXbHj
 I9NQExDTQ9aFGyN7tHzjTAzKwScORCvsyU426JE9dLGj4+EgFG/Rh0mzTqR+t344CkeHH
 PHWN7ig4VOTftq0ThZDlEZuKtmJWuuHkp+gST/Wk3hFeGJP6yRQTA4K3/B+yJHU73MikU
 70ei5AO7Eb/TrxCQ0DfHdpYmdu3+goP+USJm9i0jTlHDUlqm63aeoNibbYHN/+vfTXw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SIZxcgyD; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=W6r+Ixn5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=SIZxcgyD; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=W6r+Ixn5
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5D4060600
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:03:29 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFpjxe2761158
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +uT8Hv72MCHCKI1bzBwi/Yg9bJ3nP+ifvyHANhwZHyw=; b=SIZxcgyDUMZiLe6R
 3IZxKdRh3iYqhAlI75NwYV/5+GV+nmZrliW2VVcq2+uDF5SoXgnjH6++ANNapKwR
 OP3IWmfnHwOW0WqtCON4r9zEVM5yLEJrJqgRKqIxSpf1SFuR4XaTst2pTveHm8KH
 D3qXZWGwk9w4UWWXGNIUiz/+BtqgVu/zfAm7OLL88tg2AC37FjFUQdRWFcHJs4LZ
 yYvUDEJDW9/zDPCVXpugfugxYsJGjBTE3p0zothhIMJPI51VXaA/D0GvpslXpEQG
 tfnMayqg/gOAOjF6eojSpcnlYf3T2ATT53aGNLD0v+hUcwhh4jpiFTijoXzDOuv6
 gN4HAQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h92jjrbtp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:03:28 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-675706e468dso2453265d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791824608; cv=none;
 d=google.com; s=arc-20260327;
 b=Ja6gcz5oSvtXtvRTCNRSdjBPs0ftSa0/4Fpj9NE2XYxh2JIER7ScTt6i2+toMqIOSd
 GYVGqYejb6ePWbUod1x9VA1vtlZ2VNljOzjqB5ZpZDAzprQOrcwFn6pxc+3MqygFQH2f
 lYaGZBqfPEYa5U/e1EU5rNIOQdMZ0Q7ExVIw1f6yuL/1v1aEz3mmPQEqZQ4yFXpUpkgG
 16dD/cg2QI7M0B8Rh5cGvYDp4daIo/itYfWXAVNS/cdKgOGWaCyuyzhPcLcxH2BC8niq
 IJU/pG/Tj7x74ryIcAaI8wSBn219D8J5hUCmIppiWAofrpMW1wWOMKFYYTAwYTehdHR7
 A+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+uT8Hv72MCHCKI1bzBwi/Yg9bJ3nP+ifvyHANhwZHyw=;
 fh=WtgqmZa7PjYirGKKEC6L8aHi4sQhW8wf3eG5+KYd5EA=;
 b=RSI1CioM3QgpR5jiPdI86RmJrL1mXkxnHhecbXBgL2jQnFcCf/4PFlusudxSH2o/Z6
 Suk7f/TQ/ocVEAX8VCk7seXdJx8WqRgwoS1KI5zPlz0tS6z5MVdPABA2pvwaEwAzGl9x
 cenn7R/0bhUaXvoRidUHZMM9S+YuV8VMeR4AH6RYcmnzZEkG4rlER3OyMq/YMk0+Sj+3
 oJozXhE3qhtk7eRnBJMooA2SlUe8DVPsc6frLX3myeO5JbrO4lsDAQheaYCGt7XW5kD+
 ldQLpQmHrQ3CYKz9+fYcBLGNxsThVZ5Ls4aMEh24B0q56qo+Ol7ZW085WStEvywtWxii
 Haog==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791824608; x=1792429408;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+uT8Hv72MCHCKI1bzBwi/Yg9bJ3nP+ifvyHANhwZHyw=;
 b=W6r+Ixn55i1IT2vBuYUXBB6pBMC2EigPvHDCN+h/bWHuVXrKVSQLPjksNv49XKTD2J
 dUa53KFb9JIy5X1S0NqNMzQGY4DSVsQiRPbsWjldQB3WOKDqksBIgKNq11ypxHBJI6s9
 o4V+Yt1PChcX9sgHEWcRcN5rKWsHF2BFO2cAmbKwIZrXgCCDbVjALshKVbEptfDjVVQg
 7qOhHBB05ov/8RZFs9Q6lvSVTmCPoiebbO0aQUn+GxPYlnkhh6jFXjQcs+Jpjeqkutm/
 0nLk/B8sW4+l2096t1NytBJ/GyVy9XXaF3N0ZlgEuvOd4NtOWDwtttSrbAXrMHFnA89b
 MWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824608; x=1792429408;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+uT8Hv72MCHCKI1bzBwi/Yg9bJ3nP+ifvyHANhwZHyw=;
 b=W1uZKkag/BzkW00UK10ng03WMmBj6QiLaegwEtb03gBB+EGm3enMc+SOTl3/cq+Stq
 jNR6MrVIU9efucgzR5E6uxz3/Rrf20GkKOeKSzC8pYGqDxYwDlzpBpZ5D9GmPPMQmZrJ
 gCYKbq1AvgsbANpZnVGcca+9ZdM+uGIip97ObNPyViT723JKYReKJ7YrklRmx/5UkEw5
 J7P3MAd4CfUATvmC43yugpq+uwbciC03A5y3Lx753tzSV9Y95OZmPj/drRXsnrY4kyx6
 IWInOfEUD+IftiE05qNEiov7HX2R1bhsRxS0BTFA0jmfLetP+kLYbUB/fMDc3+YGxJVC
 FZSw==
X-Gm-Message-State: AFq9FYKInzGNP22cll5hKDGMNf7Ny2evA+ujHBVqlUn6v+Iep6Kfe4Hq
 +bTj9t6Vmd18LDOgLtcHI88mFMA/xjopcb4BkdT3MO7JFNuvst9UHpMt2oNKSyVLIM0hpFiFcYI
 hD8VjAbRFsHAcfM1PSQahSOxo5uThy+U/Q02lQNsVUmgsLpjA4E5zU+M9mN44XOOr2UMonAnfje
 tcJ1hbY/VAwuI6YP+IVW9V/WhVMJWeqdOhDNcvTHtsZpfgsQ==
X-Gm-Gg: AYBFou0LAo1gTIEoGmsa0tocvbehKsmRa+qm4h2p3T5KSzfh+tgh25LXtFWKHUeb54h
 yY5kEVYsQ9HxloIcFKONaIMs3suJaw7LrNPESga6R/AGDLn/qOXmft2/uc9aUgaHMiM+fTec9S+
 3hqH87fnAQeBWKK2CLL4+G3WxnwQYZxnrf9yJGJeRtO7cI9DZX22LME2N3dQ==
X-Received: by 2002:a05:690e:138a:b0:677:bc76:5662 with SMTP id
 956f58d0204a3-6796fe8635amr296362d50.48.1791824607236; 
 Mon, 12 Oct 2026 10:03:27 -0700 (PDT)
X-Received: by 2002:a05:690e:138a:b0:677:bc76:5662 with SMTP id
 956f58d0204a3-6796fe8635amr296352d50.48.1791824606382; Mon, 12 Oct 2026
 10:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
 <20261011-upstream-optee_rpmb_b4-v1-2-7c63edca4b92@oss.qualcomm.com>
 <77d8fc9b-ab0c-429d-a1e3-05e558188f45@siemens.com>
 <CAPzfCAbc6JQBz+VR0O72Zd7csNBSC-QSHtbnrHLL=E4g=ZKEAg@mail.gmail.com>
 <41365552-6c51-4cd3-8899-0bb5c2907aeb@siemens.com>
In-Reply-To: <41365552-6c51-4cd3-8899-0bb5c2907aeb@siemens.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:03:15 +0200
X-Gm-Features: AclHuK_UScd3i-f35R9RzOOY_KQpBHMicL22DUTMAUfzsoK0VKeEIfHUwEvV4MM
Message-ID: <CAPzfCAZcP2soDNCpfpotaDF+h9vm7L+G_4_khZpG_R=rFdVyeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] optee: do not announce RPMB from within a supplicant
 RPC
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: BKbqcyc4OKBBYnzCBi9IO27EWkNhnI0X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NyBTYWx0ZWRfX58CY3rrkuQ1G
 1BklqyrnVqd8DS/N6Vu8PEbT60JORJQmU3uvMRIf1bdZk9NFRo/2jKu/CkLWbNQMLjjWWe4KaAK
 26pUXwreEGFV7WCwy1Q5gPFciCDUGsk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NyBTYWx0ZWRfX52pvIjRLORxo
 T3KcgynIKvQFyzTSApQtVUOD/quY6NaEmCNha9uj1W5ToZd3a7s5KSuzzqQOAksggok1yLv7l5d
 03kTmWidDZJBEkzO5uZWw3nhJgDLIXCOOIT/ehHLLUnlZLvXkHlOyoNZU8971VKdg39LEdZc4se
 YMTam5RiyAmjcqAcW6dae3ngF+N4elXr6ZUMzMqGCRn7DamnO+wrzniv+bXH1t1dlGY+Ri8sHWB
 CzmE8Vl7g5C4AGtloZaVo7vBSKK5XWFI3YHSDaaltfdg5g+Q96H1ukQevG+EFeUDMBzfgt2yLgz
 c7Q66sNDDQfVGxx1yN6q3fIM4ANtSY0/RTvwkCNaOILCKAdugmgnSzhtdT/LTRRT4RRC4s2NRc1
 lX5A0nhVwQ6MD7+Z/Asxtdt6bHnWY3QqHGNXZvQfkKZdu/8/Fs2G7IB8atXDGeW+Igavi28Z1eo
 7qF9vmoJ8wdBD6Icjsg==
X-Authority-Analysis: v=2.4 cv=GfKCDgXL c=1 sm=1 tr=0 ts=6acd12e0 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8 a=a_U1oVfrAAAA:8 a=EUspDBNiAAAA:8
 a=jntPAMujVflb1yimOVwA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-ORIG-GUID: BKbqcyc4OKBBYnzCBi9IO27EWkNhnI0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120067
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

Hi Jan,

On Mon, Oct 12, 2026 at 11:14=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
>
> On 12.10.26 10:10, Igor Opaniuk wrote:
> > Hi Jan,
> >
> > On Mon, Oct 12, 2026 at 7:42=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.=
com> wrote:
> >>
> >> On 11.10.26 15:07, Igor Opaniuk wrote:
> >>> mmc_init() calls optee_rpmb_available() once the card has been set up=
.
> >>> When the first initialisation of the eMMC is triggered by the RPMB
> >>> supplicant, that is while OP-TEE is blocked in an RPC and holds its R=
PMB
> >>> mutex, the announcement opens a nested session and OP-TEE's second th=
read
> >>> spins forever waiting for the mutex (U-Boot has no notification suppo=
rt
> >>> to put it to sleep). This happens whenever a TA touches its RPMB secu=
re
> >>> storage before anything else in U-Boot has initialised the eMMC, for
> >>> example a TA call issued from the shell right after reset.
> >>>
> >>
> >> How do I trigger this exactly? I tried via StMM (env print -e), but th=
at
> >> didn't cause issues in my setup.
> >
> > The first mmc_init() of the eMMC has to happen from inside the RPMB RPC=
,
> > i.e. nothing in U-Boot may have initialised the card before a TA touche=
s
> > its RPMB storage. On QEMU virt (eMMC on sdhci-pci with an RPMB partitio=
n,
> > OP-TEE 4.11.0-rc1, environment in pflash, no "mmc" command, no bootstd =
or
> > EFI block device enumeration before) it is just:
> >
> >   =3D> optee_rpmb read_pvalue test
> >
>
> Seems my setup lacks the AVB TA.

Any TA that touches RPMB storage as the first eMMC user does it. Two
options without AVB:

- the fTPM TA, if it is in your OP-TEE: with CONFIG_TPM2_FTPM_TEE,
  "tpm2 init" right after reset is the first eMMC access and goes
  through the same RPMB init in tee_rpmb_fs();
- the AVB TA itself is in the OP-TEE tree (ta/avb), so
  CFG_IN_TREE_EARLY_TAS=3D"avb/023f8f1a-292a-432b-8fc4-de8471358067"
  together with CONFIG_CMD_OPTEE_RPMB in U-Boot gives the reproducer I
  used.

StMM cannot hit it, which is why "env print -e" is clean: efi_setup.c
registers the EFI disks, and thereby runs mmc_init(), before
efi_init_variables() opens the session to StMM (there is even a comment
on that ordering). By the time StMM issues its first RPMB request the
announcement has already run from a normal context based on the code I see.

>
> > right after reset, with CONFIG_CMD_OPTEE_RPMB (any TA that uses RPMB do=
es
> > it, this one talks to the AVB TA). With patch 1 alone U-Boot never come=
s
> > back; with this patch it does. The OP-TEE log (with CFG_TEE_CORE_LOG_LE=
VEL=3D3)
> > shows the sequence:
> >
> >   D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA 023f8f1a-=
...
> >   D/TC:? 0 legacy_rpmb_init:1219 Trying legacy RPMB init
> >   D/TC:? 1 tee_ta_init_session_with_context:578 Re-open trusted
> > service 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> >   D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
> >   D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
> >   D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
> >   D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
> >   ...
> >
> > Thread 0 opens the TA, tee_rpmb_fs takes rpmb_mutex for the RPMB init a=
nd
> > issues the RPMB RPC. U-Boot's supplicant runs get_mmc() -> mmc_init(), =
and
> > mmc_init() calls optee_rpmb_available(), which opens a session to
> > device.pta (PTA_CMD_GET_DEVICES_RPMB) on OP-TEE's thread 1. device.pta
> > runs tee_rpmb_reinit() and blocks on rpmb_mutex, held by thread 0, whic=
h
> > is itself waiting for the RPC to return. Thread 1 then tries to sleep v=
ia
> > the notification interface, U-Boot answers TEE_ERROR_NOT_IMPLEMENTED, a=
nd
> > it spins (about a million iterations in the three minutes I let it run)=
.
> >
> > Your StMM test does not hit it because the eMMC is already initialised =
by
> > the time StMM uses RPMB: the EFI subsystem probes the block devices bef=
ore
> > the variable store comes up, and an environment on MMC or any earlier
> > "mmc" command has the same effect. The announcement then runs from a
> > normal context, and the later RPC finds an initialised card.
> >
> >>
> >>> Track whether a supplicant RPC is being serviced and skip the
> >>> announcement in that case: OP-TEE is using the RPMB already.
> >>>
> >>> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> >>> ---
> >>>  drivers/tee/optee/core.c          | 3 +++
> >>>  drivers/tee/optee/optee_private.h | 2 ++
> >>>  drivers/tee/optee/rpmb.c          | 9 +++++++++
> >>>  3 files changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> >>> index a47c76811cd..b61f907a3ff 100644
> >>> --- a/drivers/tee/optee/core.c
> >>> +++ b/drivers/tee/optee/core.c
> >>> @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *param=
s, uint num_params,
> >>>  static void handle_rpc(struct udevice *dev, struct rpc_param *param,
> >>>                      void *page_list)
> >>>  {
> >>> +     struct optee_private *priv =3D dev_get_priv(dev);
> >>>       struct tee_shm *shm;
> >>>
> >>>       switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> >>> @@ -450,7 +451,9 @@ static void handle_rpc(struct udevice *dev, struc=
t rpc_param *param,
> >>>               break;
> >>>       case OPTEE_SMC_RPC_FUNC_CMD:
> >>>               shm =3D reg_pair_to_ptr(param->a1, param->a2);
> >>> +             priv->in_supplicant++;
> >>>               optee_suppl_cmd(dev, shm, page_list);
> >>> +             priv->in_supplicant--;
> >>
> >> Wouldn't it be enough to track this from rpmb_process_request? The
> >> nesting issue is limited to RPMB requests, isn't it?
> >
> > The deadlock is, yes: only the RPMB request is issued with rpmb_mutex
> > held. I put the counter around the whole supplicant command because
> > announcing RPMB from inside any RPC is pointless (OP-TEE is already
> > running and will probe the device when it needs it), and because a nest=
ed
> > session from an RPC occupies a second OP-TEE thread, which fails outrig=
ht
> > on a build with CFG_NUM_THREADS=3D1. A request that is not RPMB can als=
o end
> > up in mmc_init(): a LOAD_TA request served from a filesystem on the eMM=
C
> > does exactly that, which I have in a follow-up. But I have no strong
> > opinion; if you prefer the narrower scope I will move it into
> > optee_suppl_cmd_rpmb() for v2.
> >
>
> If not only RPMB requests could actually trigger this, then having it
> over all commands is fine. I was just wondering where to place it best,
> here or in some of the invoked functions.
>
> But looking at optee_suppl_cmd(), though, I guess optee_suppl_cmd_rpmb()
> is really the only one, no? At least it would look a bit nicer to do the
> state tracing inside optee_suppl_cmd.

Agreed, optee_suppl_cmd() is the better place. I will move it there in
v2, together with the local variable in optee_rpmb_available().

>
> But if you have more requests on the list, I wonder how that will fit
> into the picture. Maybe you can share the full set of changes to get the
> full picture as well?

the whole tree is here, on top of next:
[1] https://github.com/igoropaniuk/u-boot/tree/android-avb

It fills in what the AVB and A/B implementation in U-Boot is still
missing to be usable in production as is: the device lock state and
root key provisioning, verifying the boot images in the buffers they
are booted from, init_boot and dtbo, the managed dm-verity mode,
rollback index updates once a slot is known good, loading TAs on request
etc. Everything has been tested on QEMU virt with OP-TEE and the Cuttlefish
Android images to the point where Android reaches boot_completed with the d=
evice
locked, and it is being split into series for the list.

The request that matters for this discussion is
OPTEE_MSG_RPC_CMD_LOAD_TA, U-Boot serving TA binaries from a FIT image
in memory or from a filesystem so that a TA (the AVB TA in my case)
does not have to be an early TA baked into the OP-TEE image:

[2] https://github.com/igoropaniuk/u-boot/commit/2029a3bd16641668ed37bd19d7=
a0f0570ba795c6
("optee: load Trusted Applications on request from OP-TEE")

When the filesystem source sits on the eMMC, that request is the first
mmc_init() too. There is no RPMB mutex involved in that path, so it
would not deadlock, but it would still open a nested session from
inside an RPC, which is pointless and fails outright with
CFG_NUM_THREADS=3D1. That is why I would like the tracking to cover every
supplicant command.

>
> And what does the Linux kernel do to prevent such deadlocks?

It never announces from inside an RPC. The RPMB device is created by the
MMC core at probe time, long before any TEE client runs, and the OP-TEE
driver reacts to it through an rpmb class interface notifier that
schedules optee_bus_scan_rpmb() on a workqueue (drivers/tee/optee/core.c),
so PTA_CMD_GET_DEVICES_RPMB is issued from its own kernel thread.

The RPMB requests themselves are served either by the in-kernel RPMB routin=
g
or by tee-supplicant in the user space, both separate contexts from the
caller. And Linux implements the notification interface, so an OP-TEE
thread waiting for a mutex is put to sleep instead of spinning on
TEE_ERROR_NOT_IMPLEMENTED as it does with U-Boot.

U-Boot obviously has none of that: a single thread serves the RPC synchrono=
usly,
hence the explicit check.

>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
