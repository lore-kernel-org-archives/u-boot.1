Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CE606A324
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fg1/Xx1L;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KdcBMmig;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y3HIOWmx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DB4D6078F;
	Thu, 29 Oct 2026 10:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EcYLFo17fpg4; Thu, 29 Oct 2026 10:58:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 610C860731
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271484;
	b=KPKnrxX/YhyI9UepEEhOa02cyCCHMb5npfAk1em/b6XEZ5RAClJJDVLHt+6l9I3+3ZD1
	 flLO9e4spKp964fzqw7Pxu33lkMpAmTCCqD5LJRj7qUgioS1QTzr+bCxhTfaFfaTYOCd6
	 /uTso+40SdXGMXiVV5zMhLDlZ+G1wTnn1j0/W20s4+xykltEuBJPO0aUJynx7NHDevvD+
	 CtoTRof5GIl3Flw7zM+NWEC7j1UqN0sGm4NZ7Lz2Mulg9FTgG2CjaGapAppeNsKl/VMtj
	 3onhhLl+5tBUWatNsuz1Hc3D5Vc2VLnz0yqAW7PmyN0fun3hTQ52Lz7OSBS/qEeiMdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271484;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cmnz2pGuKJoIcWPrivPjb0spJT6j5C9AVeGUCK/YzSA=;
	b=fFj54rtk8UHUaHWUBX4fF79QWgMXsQuOM+z2vmF1W3EKEFU7jz2/2V16gQsNi7pitfJa
	 TVp0YtfxZxOoGir93u72Rtwgv6MWYV6t9uvtV5pDG3dnUNIAW+y7xAV8ebkuLjcrvX9Hf
	 DaEdCX36hKED9unVAU1CTVwzIsdR1LwJqp0v7L5yGG3tKjbUGdOXaoOouAfoy8GbC3CqB
	 +P+yqVj/8pOSowZieNg1pF12Au5wPS/dQ/b+89X/t+qzHb3lkq6NnNWriNk3vp1wmDuoR
	 K+RoQZomjb7kqJeSJ9SBJJuIc53CWe7TpyLxXQkFPHWtcwA58iU4i1NyvGv/dM6IZZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271484;
	bh=cmnz2pGuKJoIcWPrivPjb0spJT6j5C9AVeGUCK/YzSA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fg1/Xx1Luz1d+IHFY8Q0okjkDz4yvSsaYG0QRpVunxidJE3uVg6Ydp0RyVdohYOdB
	 2e2EjTvkLyJqhu+a3EFQULLxAO3RLin84nKF4Fli00JtA1i3ibAzOW5v53AU2NNOpX
	 z8nULWVZEvMzdILd7/JaugXz/YjrfsZL0NJHQ0UcWwlXBfGXN6Ecn2aCC7R6SbOYc3
	 ocBoSKoVeQebCUbanr+W+rKMIMI/p7j0jOfaGKhxj9nv+R5GeHzIBuIvAE/ZRGZfsY
	 5hWZ/ZTvFpnZ31Ofdej5loTgn75efxWIvEsp5xHDM/ndg4NiIrYfSDKrnakMhu59ly
	 BzOBKiy2Az6kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 610C860731;
	Thu, 29 Oct 2026 10:58:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1658334
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B300140764
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z67LeJZ_YxuS for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:57:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B809440763
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271477;
 b=IRxIpq2ohc+j+MGY0bDBBun9ZqrKj0LrgW3bcf1aWleasmZwHWIkPDMC3lU7zq4rl6Mo
 D3As0zJSyCyVFDdOyYRfZ85HW1nN5GaM9xuOuwleVz/B5zicczyQ6Gm0xH6QOe6mQBdbR
 p1SXjYZZ5Uw4VEgZHWPIeXa2F8YEauWZN4EieCGYpkCNDWalMfsEtwCOSB3v+/VVyfTID
 6+vKKTp78yZfLnpSXx0TDFzY9x/mOpxdY+IZN9+CMBcya5FrPrHAWCdSIjCwUXyEgN/eX
 mw5WuFM09wJT/EI14W0Fnq3Sv/rMXIwOlYGn5h+eL5fiPDLbWFL/fK8ipcnwlk0reRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271477;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=cmnz2pGuKJoIcWPrivPjb0spJT6j5C9AVeGUCK/YzSA=;
 b=hCHpCRpSYPeGpfg03/vbUFhKchwhQeNqKAQN1NiK+18NtW1v3F+cLzJJVMhBh9nwtO9U
 K2dH9elG5azWp/F38BJb3RouRda/bE30G1Nwm0Mf/5gaOfex5NvkJOGfYxgqZ7oTc+WlZ
 CTLV6XhtGzuz5NWqsjmczCMt4Y4sgU+pGogE3EgiVXvCWyejJApFlPtshkbedbT9qe2tT
 LN+F4JUpOLHRTeD1+vNQfCqBHN5kYQbkxuOxwOYNfFB7ryw5syrDwYXkiRGXiKgPflu12
 uPzBBje/esO1E8jw73LMpwQoiYLdyPpl+i3YlKcJj6MGbhP9c1EmQEzocmirQiXPpLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=KdcBMmig; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Y3HIOWmx; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=KdcBMmig; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Y3HIOWmx
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B809440763
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:56 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8v9Hh2273151
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cmnz2pGuKJo
 IcWPrivPjb0spJT6j5C9AVeGUCK/YzSA=; b=KdcBMmigqmW3X+FbSpDo6rsAOU1
 ASEjtnl2FcYlkL+d/meoi8CZSlOingOHykLNT8mVgz0ZhXRSror5mQ/GIgdR22TD
 9BLccWBPhl6Udiu/MFAZ8Fnz2gSuCiPBytSxQfbG5rqT/yYLRRcmuBLde7qtyPDh
 CNANnx0/18M4Y9/DBLHyZtaEaSyPaICCTBvNXmOSb3+s3s3gHR8s8lO61khoCfwf
 xoZLFu+QE+8mdChK0/g7wf6x8WEogRHwfECRcP/T35/wWh+gHhNS66a+T2SuM70z
 yOIUEckioH2UMYtmg74vp8MDKWekMlJwPaaYXU1P20qGme6Pn4cc+Crtllg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b0fm6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:55 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-147be78cd56so6093508c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271475; x=1793876275;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cmnz2pGuKJoIcWPrivPjb0spJT6j5C9AVeGUCK/YzSA=;
 b=Y3HIOWmxk8lB/GT1bQDDxASuxX1ijEjvdSgdMnDrbApfQbBtToECZcNFn3CYjjSEFT
 n7raUkSb+uFfSDzq6dNLG0hFEcRTnSfBF9H6j0idcNqvGkZt57GMnLhoGxqrDWYUydxS
 adP+bmRy68Nd1jd68d4MKZFiKD+F4CUeVW7xhXhAaeJ9/j4j8D7RDHzHo7ElXrjxEbaR
 dRmWO2nqT8xFMlCaSi0wXDI8UBPSExpQvLVP+mP6A/lGaDZ3n7JbiKUjc/ZmEwWpK3Lq
 NrtY9Q3/sS4ZafWe4bVSqCiBcpMbiEnaOlrAvuW4mU8tbKxKPioQlgi87lwgCpBwVBFI
 U7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271475; x=1793876275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cmnz2pGuKJoIcWPrivPjb0spJT6j5C9AVeGUCK/YzSA=;
 b=almEyAG4SIWsbmR+YMWkrldbjf5op2llEHKX2SEOkNW8c/dXYCFmIrH6cE45jb9yXn
 7gCfslRp5A1r8dPX0Zak0005iSWMRwdDCOL4ldztTeEMnonJhU1mo2VKvxUBcAuTdA7W
 tAaBxpPaarFnmxmpDJwa+QsQtJPgjS16kJt3/mRugTl6XMSprrCl7yCy5ywmLg54bplf
 6qeAnFdsKbDJZ19V67jWNF6lSj2jxe/YIdSnosnDe6lFkVKFvbuFk/ebQ7MMYfVFydD7
 RJJmxcjid8JraSnWQUagdXn+V5H4HOC7s0PwTV+2VBKLmvjynrJSUXirNbPuy1dzWoHB
 GZ9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNPoNR/CV5L3RGzjX8hrd3mjMTMdGtHeM0pP0lUghAblqhnSi01hIi2uPZQp/X05x1/bToF4Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJaimPyhBgPmAlpkYZCQVaDwTolf9GjN1k4YtjBAF6NMs/Rth6M
 27DCPvpBQjrdORXkNvyVS1+/2a9JwNjwPEmLHbnJ1qaZZcg0gnqU0xrhtHHCs/ln2TbravY2ZTw
 tvAExjNBtoXQa7jEhamXcFf8d4cHXyOwXRsFxN3fMlRCZ6NpEowq/KKm2xv/jOcg/oSQ9UOs=
X-Gm-Gg: AYBFou0J46OLgCGtduMUoiyS6A73AlrD+53CqgSn/By7QQGJfahGmEQ/lgx0igJW5ZV
 b9NhoXCgnYyBEl5O4kd92KPk9ulpFmEttrg2Tc6vK2zT5NDM41ZghnyXJRB6dVzBrR/wxSgsCHk
 htDbFMXLQvvHMXkwus0FFdb9Y4Qr+P41MJRTH8nJygGzRQkXY0HnZ6Z6SphBm4Tmc32m7AJ6dYy
 38piSa5SGP/napJeltIpEJMVM9uZH2BoxLmMG+deH8ybbudvUczfpvuoHQQJ4BYy4HRGGTOrFs+
 OX0+n5dbODb66DwkM+zrpCdTJjg18bFft160h7W+ZHDILcBt4BA9qbMWON6cue4Uii1PXR/V1EB
 wGaYoqA7L5ReyEwExO66fBCsU2J/TzKw/Y6D6iBaOhYmSn6JYv261QuK6qa7n5LrAX9APHqVTDm
 qyZI+0MpQfFkq8FgEyj1PeFg==
X-Received: by 2002:a05:701b:42d3:20b0:184:d593:2897 with SMTP id
 a92af1059eb24-1a6cdb53489mr7747695c88.29.1793271474518; 
 Thu, 29 Oct 2026 03:57:54 -0700 (PDT)
X-Received: by 2002:a05:701b:42d3:20b0:184:d593:2897 with SMTP id
 a92af1059eb24-1a6cdb53489mr7747642c88.29.1793271473911; 
 Thu, 29 Oct 2026 03:57:53 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:57:53 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 03/13] board: qualcomm: shikra: add SPL board support
Date: Thu, 29 Oct 2026 03:57:36 -0700
Message-Id: <20261029105746.3487456-4-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX02YwMJswimUb
 AnPPhPPkuEEDHPI+9L+gFA6FQcVe3XJl+cBdK+SJs/cKjxcR8Tt0deCiZVb/vv/LMweX0xKKKlv
 yY4sUe2f6RwDeF1NgvU5lExUfeKNrwk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX9Dc67jw3pojR
 gjCthvTpJeXXLc8Ofy5qDDo5Ivt2Yp5IVARQu16VJsqvqFgrYWGIk8h0Y9jLNbLfiAdbIIrkHVH
 wen3RRThA5iYtidc6fVLkkJ2GSLrRpi+iNBd+y3Wsmlrrtvy20H48cWKQP6uHEBafVZ9YqtIM6U
 rlu+pBXcSAd4Ai3pMNyuKL9ne4tCvXvPlvyc9VzuaVkqFyYQzAw9UwhL65GxzHa9/FD+7gHTGxT
 MIeKOs8dZYnqm4xkmnl0Ys7+pVSOhEhTEE5kpox4Vg4F4iDehf59jxU8vUw2zda+IC87KzIzoT9
 GyqeKL/fFXeSrcPXbyV24rnd+2x3NgJ2keXOwc9ooxowUBuFT6kF5gwYuzPr2FhdJQLYP1QZ/kV
 cuzbRhgHhPNBy+BrQrtDCX6mzN0aFkPjVnLcvgwkx+YDvLtbbGg/Zi2Ftj8ZxQ6uZg80MMnk55I
 XbfJMY4Orexw5OJmCtA==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae326b3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=tJ3Jutxesx3invMfXmIA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: LS-2wxMFwlUUOOtEN8rMxuFWv9HbEVtg
X-Proofpoint-ORIG-GUID: LS-2wxMFwlUUOOtEN8rMxuFWv9HbEVtg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add Shikra SPL board implementation, build rules, and linker
wrapper, board configuration header, and QCLIB handoff data.
Configure early reset handling and MMC boot selection.

Decode the Shikra boot configuration and map eMMC and SD
sources to SPL MMC devices for boot-device and FIT partition
selection.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          |   4 +-
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  18 ++
 board/qualcomm/shikra/spl-shikra.c            | 194 ++++++++++++++++++
 include/configs/shikra.h                      |  11 +
 5 files changed, 228 insertions(+), 2 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 4e3b2527a7b..31a06b1e002 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -141,13 +141,13 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
  *
  * Return: Partition number to boot from, or default partition on error
  */
-int __weak spl_mmc_boot_partition(const u32 boot_device)
+int __weak spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	int p_no;
 	struct blk_desc *desc;
 	struct disk_partition info;
 
-	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	desc = mmc_get_blk_desc(mmc);
 	if (!desc) {
 		pr_err("%s: Block device not found\n", __func__);
 		return -ENODEV;
diff --git a/board/qualcomm/shikra/Makefile b/board/qualcomm/shikra/Makefile
new file mode 100644
index 00000000000..eb3961a3ead
--- /dev/null
+++ b/board/qualcomm/shikra/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SPL) := spl-shikra.o
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
new file mode 100644
index 00000000000..b2922cd2c2c
--- /dev/null
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
new file mode 100644
index 00000000000..b41877743b2
--- /dev/null
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <blk.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+#include <part.h>
+#include <spl.h>
+
+#define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
+#define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
+#define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
+
+#define SHIKRA_DDR_INFORMATION		"ddr_information"
+#define SHIKRA_DDR_TRAINING_DATA	"ddr_training_data"
+#define SHIKRA_DDR_SR_EXIT		"ddr_sr_exit"
+#define SHIKRA_PMIC_COCOS		"pmic_cocos"
+#define SHIKRA_PMIC_WAILUA		"pmic_wailua"
+#define SHIKRA_DCB_LP4			"dcb_lp4"
+#define SHIKRA_DCB_LP5			"dcb_lp5"
+#define SHIKRA_ECC			"ecc"
+
+#define SHIKRA_DDR_TRAINING_DATA_ADDR	0x0c368000
+#define SHIKRA_DDR_TRAINING_DATA_SIZE	0x8000
+#define SHIKRA_PMIC_COCOS_SIZE		0xbc00
+#define SHIKRA_PMIC_WAILUA_SIZE	0x6000
+#define SHIKRA_DCB_LP4_SIZE		0x4800
+#define SHIKRA_DCB_LP5_SIZE		0x4800
+#define SHIKRA_ECC_SIZE			0x400
+
+#define SHIKRA_SHRM2_SPROC_CTRL_ADDR			0x0c36000
+#define SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK	BIT(1)
+#define SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK	BIT(3)
+
+/* GCC_APCS_MISC contains the RPM reset control bit. */
+#define SHIKRA_GCC_APCS_MISC_ADDR			0x01491000
+#define SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK		BIT(0)
+
+#define SHIKRA_RPM_STAGING_ADDR			0x04690000
+#define SHIKRA_RPM_STAGING_SIZE			0x1363c
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"uefi_a"
+
+enum {
+	IPQ_SPL_BOOTCFG_DEV_MMC = 0x0,
+	IPQ_SPL_BOOTCFG_DEV_SD_EMMC	= 0x1,
+};
+
+int qcom_spl_soc_qclib_override(struct interface_table *table,
+				const void *fit, int images_node)
+{
+	static const struct {
+		const char *name;
+		u32 size;
+	} fit_blobs[] = {
+		{ SHIKRA_PMIC_COCOS, SHIKRA_PMIC_COCOS_SIZE },
+		{ SHIKRA_PMIC_WAILUA, SHIKRA_PMIC_WAILUA_SIZE },
+		{ SHIKRA_DCB_LP4, SHIKRA_DCB_LP4_SIZE },
+		{ SHIKRA_DCB_LP5, SHIKRA_DCB_LP5_SIZE },
+		{ SHIKRA_ECC, SHIKRA_ECC_SIZE },
+	};
+	uint i;
+	int ret;
+
+	table->global_attributes |= QCLIB_GA_ENABLE_UART_LOGGING;
+	for (i = 0; i < ARRAY_SIZE(fit_blobs); i++) {
+		ret = qclib_add_iftbl_fit_blob(table, fit, images_node,
+					       fit_blobs[i].name, fit_blobs[i].size);
+		if (ret)
+			return ret;
+	}
+
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
+				    SHIKRA_DDR_TRAINING_DATA_ADDR,
+				    SHIKRA_DDR_TRAINING_DATA_SIZE);
+	if (ret)
+		return ret;
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_INFORMATION, 0, 0);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, SHIKRA_DDR_SR_EXIT, 0, 0);
+}
+
+void qcom_spl_soc_shrm_reset(void)
+{
+	writel(SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK |
+	       SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(0, (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+}
+
+int qcom_spl_soc_pre_qclib_routine(void)
+{
+	qcom_spl_soc_shrm_reset();
+
+	return 0;
+}
+
+void qcom_spl_soc_rpm_reset(void)
+{
+	clrbits_le32((void *)SHIKRA_GCC_APCS_MISC_ADDR,
+		     SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK);
+}
+
+int spl_check_board_image(struct spl_image_info *spl_image,
+			  const struct spl_boot_device *bootdev)
+{
+	qcom_spl_soc_rpm_reset();
+
+	return 0;
+}
+
+int qcom_spl_soc_post_qclib_routine(struct interface_table *table)
+{
+	struct interface_table_entry entry;
+	int ret;
+
+	/*
+	 * Clear the full memory region reserved for the RPM image before loading
+	 * the post-DDR FIT, including its zero-initialized data.
+	 */
+	memset((void *)SHIKRA_RPM_STAGING_ADDR, 0, SHIKRA_RPM_STAGING_SIZE);
+
+	ret = qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_SR_EXIT,
+					       &entry);
+	if (ret)
+		return ret;
+
+	qclib_set_ddr_sr_exit_address(entry.address);
+	return 0;
+}
+
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	int partition, ret;
+
+	if (!IS_ENABLED(CONFIG_MMC))
+		return -ENOSYS;
+
+	if (boot_device != BOOT_DEVICE_MMC1 &&
+	    boot_device != BOOT_DEVICE_MMC2)
+		return -ENODEV;
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret)
+		return ret;
+
+	partition = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION,
+					  &info);
+	if (partition < 0)
+		return -ENOENT;
+
+	return partition;
+}
+
+/**
+ * spl_boot_device() - Get the boot device.
+ *
+ * Return: U-Boot SPL boot device identifier, or -EINVAL if the device is invalid.
+ */
+u32 spl_boot_device(void)
+{
+	int boot_device;
+
+	boot_device =
+		(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+		IPQ_SPL_BOOTCFG_DEV_SHFT;
+
+	switch (boot_device) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		boot_device = BOOT_DEVICE_MMC1;
+		printf("Selected boot device: MMC\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		boot_device = BOOT_DEVICE_MMC2;
+		printf("Selected boot device: SD MMC\n");
+		break;
+	default:
+		pr_err("Invalid boot device configured\n");
+		return -EINVAL;
+	}
+
+	return boot_device;
+}
diff --git a/include/configs/shikra.h b/include/configs/shikra.h
new file mode 100644
index 00000000000..7d88dc0e670
--- /dev/null
+++ b/include/configs/shikra.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_SHIKRA_H
+#define __CONFIGS_SHIKRA_H
+
+#include <linux/sizes.h>
+
+#endif
-- 
2.34.1

