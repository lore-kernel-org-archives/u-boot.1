Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F44606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VyqNr3TB;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ITQ3rB6g;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VzcGLGJm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA3D36074E;
	Mon,  2 Nov 2026 05:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0CoCue-b7vMl; Mon,  2 Nov 2026 05:52:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8AEDF6072F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598769;
	b=FlC/zMPrSfn/rj0VFLOYG2cod8J7V2oqLFcdMVjALXTZ9hiTVeqeOof2J+hPDkN4uUBg
	 /bezDhqbunaq3cbb15Uc8wfZkOEj+jVZ2WRUhFXmySeRj3YK5ncSikKbyZFnJK84XE6h0
	 WxfW9j68ADnabdExjMwhp0Z3tE4hey1qcTvXf9xV21Wco52xFC2tAEQsQzqXeAfusDBfH
	 Z4I/wqnhyYUNCOY+qGSKTa8WQqIrnWcIVMeYNCzXUcDQMNttGNQIfX3ajj5elsXk4v4qL
	 8Bqh7eO9vePAbbXdsfrWGzlSiP/xdV7PChLQvsL4EVxBL82ZXAhpVljROND88U/xOXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
	b=TDbMqRr1aV0IEe3FU4g0PkamoOgv4lb1iFDjGbAaC/DpMCMTDYg5/CllWVg+KrH/f7Mh
	 GEbviwyvKW7inVkYBKLxKQdAtAjfY5dcR0vSI6YfS18aO8SNfQ153fqPzkgRyFrHfQfrW
	 cXkBZ1vSMoYdq20tsfzAXtUebpzJVcXRxMBAFBsz81VsVVR3fQRvV+3VdfMSJR+WlwBdR
	 s0uHH9iInFZMvPFLusMNqIFjqjHWUCHBHxQO9uEUISo5Fq7USRqXIz83dN+sbOH6aL0z9
	 TJqB6TlwyROnkQ8UW9x0sFHQHlLD4OiWCK9FcrgxGqmYjFWSdfUPQ1hFOwJtIkJuUBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598769;
	bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VyqNr3TBQ0u7qyHfER9FHq8meLGD1nMzuDDNImBl+rX6kOhfM5dCHYs3oBbkzZi2Z
	 9Tt0xLkWNYsnyJ9LNKr9v6BNYYXTZr1R1ho24jqhg06ad5CI1RsbmL8tueRhGLh3Wm
	 6qV+YtFMShwpaPuyArT21V4EOFZAy1Emmv4okH84gMA7jxZ12rGI9Ctas8g+KpaEVT
	 UrRvQ7U9oIp9jwhddKOfOLAYTIhoiJPfCCjyGQ2d6kYrd4xr2G5RJXsmEvF+/HXvlh
	 JPH3vMgM37cWVWpw2ABYkJAtBXyB/4cY4ozd8m0HmzuNqUUt3Xd1u0/XrsFpk34hHa
	 6jAgm/Xhf3cSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AEDF6072F;
	Mon,  2 Nov 2026 05:52:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AD742A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C98380E0B
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oea3wP3j_mOf for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:52:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8956C80E0A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598766;
 b=jaD0IkEovlfBLKOPB4XR6wI5Y9Rg38mEWrMlKnkPLqOlQwRZDZInpuUjucdjpAHWeUhb
 9RxseiKITPekIJ4CHHI/SLNLkDSha5+zXzZNyVVBRSqduT2ndiKAHm1+5+1QIvj56njE7
 92Cc5qCXtcdAdikCNZe4sT3WaN1wP5QllI5SODsochHd9kpC+BbwGB0yKHvOKcfxOF68u
 p1dcqlvmnDJ+14iZhJopEihRpREW1j+9apPfI3/Z8y5LgShbmBM5vOa9mXsNWloX1M0FS
 4rnB3ytU3U47XLy2s9qU2FEWpB+wlZoXBsQZmsqMhbdzR4BDsgHetLwGAq4CnC8o3Hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598766;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
 b=BSsVnQKXa+pS24OauAj9/ywRYlmyIg65I9itVZfM0+58S4m/7z5AvSi67fIe30AC44Mg
 cap4e9IdjAGZZty4EiQ756WoJOIdTxB9OqpcFRPcRO2mRy9VfqcT3b0/21HACnQUYzhvf
 qySDeW4uHwUupv3UIdRWwv8pW1Er2IlILsDmhXO2bz5AfwuDZ+SOAeBrgR6JwY0TfOeqI
 Mez9eRl6+7tIoL1XhdtC/7pv9gHf9x8fpCSZhlziuDyTEVm5fh+8u8jwYLG4tz+/mE6tc
 1gMnQY7acDirvYgvstloloT9MiBJNsLnWX4Ck2kBtXEXUuso/Gu8vVxY0RydsdmIC8Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ITQ3rB6g; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VzcGLGJm; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ITQ3rB6g; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VzcGLGJm
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8956C80E0A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vI2f3324645
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=; b=ITQ3rB6gbkz8fvPb
 BNrOMawxIwcQWmysw/NidqI5K1CUS6KQ63fdn3WLMnhAUj4wMz2Kuv+d9baqhbbU
 5hCeKkHmPTWKA1rbR58VCJxANBB5QsxWok05nEerXmYqiLfLch35C8lipy+gW+Xh
 CXv4/+MddBXZ0SiQaySD62uG5Ds4QIin6kTMITOYqAkywwP/lY9i3djxAbbMnvwS
 A9bsGE0qAktC0VJR/t4PJLvt/P9Szjrobpy9ayexLRiwcz5P2CJaUEUjB0uddQ1o
 wlLoMiT+WTUXKmlfELVn7at6f1OZ46VGcQ8WvCMI+dPEg9wQAzGbtkXYuMpzTSNR
 vO5Y1Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6nfya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:52:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso3278950eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598764; x=1794203564;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
 b=VzcGLGJmuJqFaaQlhqX0QrNZHrVCEo+bB0H+kbwk00NRuLkdRbUJqpuzFlIklWz47X
 0ArqqruaR6tBxBMjpM9lVEZkiWAdXlH7OlOC+87knw6Q6WL7YjO3VWUV4DaI2JnAO7E6
 sJXFUvQcAezBg0YovWcOb9VHREGx4jzCmW8avvKoW2ogB4RBYVhMFbjI1FnWJNjHyLK1
 uVy1nBY3MBG+ToZdXNLNlaFbt0xwoIxdgmgugEMRrzYyGMOiJFbJUDINuUSw9/1pLfiV
 etk4WCsWjrshn0K9leI6GDL6turbV5WcTRB/vXW4di/eXln3Ow1PRY1NnLorWrv54XR6
 qhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598764; x=1794203564;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
 b=REr1ZCROHTDPCOdnAXLghIDxmfsgu9kuLvDLifdScKaWxYtxcKwP4prN8OKGzYEq2H
 t+h9vYm8c2440sCcNK8TwCxhx+C0/X2Vfc4uliiEHVnJ4aYDjq4RYt6ePG4fEDZr9q5q
 tU8P3FEBXJ9ffpKMf8WPT3HmTKXhDO/2/mM+gpUt3xUaUXxbVhbpPSivmcj4R8fjnbPd
 XBZhT0OOKD9CREHK5GYZWsZsG/7i0aw5c+DwJ3gxgjUR+2b66wqNg9OhqKkp1z6B4tlO
 m6j0k1PLZh4Qs1zogRzumKqvu/Q2es8P1XMdymDScaRSy9248LtyQl6F4EoNftpDBZSe
 xG9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBRbzVv6gzJV9+m7XBxM6S2ax0ZU54eCG0d9JG7/lQ6qxx7YMGGCOmmgsEJwEzjgw5gcU8jZw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ2dfNTBAQ28CwR+RRx9NUVwURGhKiYM7lh4BsxZmgrmiz8nXR6
 4Xj8A2ai5fOs9BQpA+vgxJXHTozY1lOk90axqb9I6xUhvFSSQpKl2EGr1WIqYfiQ0XG5217gzrL
 4p5cs2NsG2iY75EiCPD38ZmnBbSdQKRe4qQjjpfGGr7rN+CxH2nv3UhuRWBJND2dYHZhWuv8=
X-Gm-Gg: AYBFou1i9CL+6K+EkdtaWlB7zMX26EWgicv+YF4Fm+Gk54JA5WFk+vSHfZ9CN7IYD+Z
 aga2w0gwDEyILmaU3NNrG60KOSi/uUk7X02y7g+exwwutTsla5nd8l2sPuYxNHMp4zzf+4O8GCN
 52+ModIst/vP4+N0afjT1KNqeuDErr0bTip17Kuv6CbZruvD8/cB7iW3K18qfE0fEYcqHoOyl1A
 /opa57N8i8KAuuK8clrhzhEOLwKY9f0F2zH8OGJBNeMz2unUOS+JuTfgebak/emBmDJLtJzZDDh
 1DzwVBs59wczExtVs/kEwZa5q+U+D89LyO7te0jy/hXReL3D2gI5cBxxpfIzPcI+Ug6V6chOY6b
 6uoVzKrd3HdaK7UWv5obyOdfKOG5h8IbRriqPu8GS5r5PrbX6A8QDRhv9DW98MMzAASC8ialEl0
 MF2ukG0cnaBIvmb6zPhCjzK7S2zObD81aJB8y7FiXQsOeJMk3dn4ccO9G9Qr597nninM1kJcQne
 Ji+HA==
X-Received: by 2002:a05:7301:648d:b0:36a:f55:5c6d with SMTP id
 5a478bee46e88-36a42388ffamr14742244eec.14.1793598763138; 
 Sun, 01 Nov 2026 21:52:43 -0800 (PST)
X-Received: by 2002:a05:7301:648d:b0:36a:f55:5c6d with SMTP id
 5a478bee46e88-36a42388ffamr14742207eec.14.1793598762547; 
 Sun, 01 Nov 2026 21:52:42 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm35456366eec.7.2026.11.01.21.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:52:41 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:22:28 +0530
Subject: [PATCH RESEND v3 3/4] tools: qcom: mkmbn: Add support for ipq5210
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-ipq5210-v3-3-aacf3930848b@oss.qualcomm.com>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
In-Reply-To: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: URuvwOhVPPV6qnLvV7oahB4Q98GT1Lja
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae8252c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=yH3UP6-NtsxmdlPH3hAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: URuvwOhVPPV6qnLvV7oahB4Q98GT1Lja
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX+N8m3Bkntt4v
 VKXAiuR+Cbl2r2KGzLRS97IU61c8UwsptIhbtJai6jMEI5DqIcne+2T8r0YNw28ZWs8C7wj3d8q
 vtKeIyUhtpzUXZefda3ioeLWm4uUXD0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX/AZPoQIi9Xqz
 0srjV/ypt6Wxr+F4mjDQRyotsFlgPDe6D82/etA87UhgoHWmuwA5SiQSkylOBWhdph78X8uIjtO
 EtrJj1DV78HZFAVY2KUYlBpB/yf2K0TvS6H7MdnRPbM0k8NN04Y+GDAGjZy66RDSTUk3r4StGzT
 psvx05zbYToN5kuZKXX4Ih9dIOjjJOF7somgAkRmFWd+se3P65kWmLwFALK6vj7Ewh04UYEvBNs
 7dAenfS+r/Y1ecUKHdeooxAO9EuxKcfxbCTB+u+nQONeIOZdqzINESC412VqF6wT8Jr8034t+KH
 DzKoxw0tdJcz4byu2zkfIi/Wy1pgALYlBF2OwPA/x2pVN+C6XosJ4QwwFdnXt2KEjQajGQlUrsD
 yqEY2zvkzpEHdYEdHqGVJadi8KXwyBX6IuEofFlKZtYYGD/N0jX0Tj2PzTUCM1X1AnXiEq1snkl
 +1J1eJpuHtdtaqD8+3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020023
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

- Add ipq5210 entry to the 'boards' table
- Add an argument to specify the U-Boot Proper/SPL load address and
  drop it from MbnData
- ipq5210's boot rom expects the SPL image size to be 4-byte aligned.
  Enable the mkmbn script to pad the image to 4K.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 board/qualcomm/config.mk  |  2 +-
 tools/qcom/mkmbn/mkmbn.py | 63 ++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..dd61ffd98e8 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -8,7 +8,7 @@
 # Create Qualcomm signed elf images
 CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
 quiet_cmd_mkmbn = MBN     $@
-      cmd_mkmbn = $(CMD_MKMBN) $<
+      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_TEXT_BASE) $<
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index 8d2078acc30..da4d45b600a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -18,6 +18,8 @@ import sys
 from enum import Enum
 import struct
 
+MBN_ALIGN_SIZE = 4096
+
 verbose = False
 
 def log(*args, **kwargs):
@@ -56,42 +58,40 @@ class SwId(Enum):
 class MbnData:
 
     # sw_id 0x9 is aboot/uefi, the most common
-    def __init__(self, loadaddr: int, version: int, sw_id: SwId = SwId.aboot):
-        self.loadaddr = loadaddr
+    def __init__(self, version: int, sw_id: SwId = SwId.aboot):
         self.version = version
         self.sw_id = sw_id
 
 
 """
-This dictionary is used to map a board or platform to the appropriate load address and
-other MBN metadata. When adding support for a new platform to U-Boot, the appropriate
-data should be filled out here. The load address can typically be determined by looking
-at the uefi.elf or xbl.elf for the platform. For the uefi.elf it is the load address, and
-for xbl.elf it is typically the RWX section in the middle, just BEFORE the section loaded
-at 0x1495xxxx or similar. Looking at similar platforms in the table below may help.
+This dictionary is used to map a board or platform to the appropriate MBN
+metadata. When adding support for a new platform to U-Boot, the appropriate data
+should be filled out here. Looking at similar platforms in the table below may
+help.
 """
 boards: dict[bytes, MbnData] = {
     # Exact matches for boards, these are preferred
-    b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.uefi),
-    b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,qcs6490-rb3gen2\0": MbnData(6, SwId.uefi),
+    b"qcom,qcs9100-ride-r3\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs615-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
     # Fallback/generic matches since most boards for a platform will
     # use the same load address
-    b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
-    b"qcom,qcs9100\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
-    b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
-    b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+    b"qcom,qcm6490\0": MbnData(6, SwId.uefi),  # rb3gen2, rubikpi3
+    b"qcom,qcs9100\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8650\0": MbnData(7, SwId.uefi),  # SM8650
+    b"qcom,qcs615\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,ipq5210\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq9574\0": MbnData(6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same
     # They use header version 3.
-    b"qcom,apq8016\0": MbnData(0x8f600000, 3, SwId.aboot),
-    b"qcom,msm8916\0": MbnData(0x8f600000, 3, SwId.aboot),
+    b"qcom,apq8016\0": MbnData(3, SwId.aboot),
+    b"qcom,msm8916\0": MbnData(3, SwId.aboot),
 }
 
 parser = argparse.ArgumentParser(
@@ -100,6 +100,9 @@ parser = argparse.ArgumentParser(
 """
 )
 parser.register("type", "hex", lambda s: int(s, 16))
+parser.add_argument(
+    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
+)
 parser.add_argument(
     "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
 )
@@ -149,10 +152,18 @@ if not mbn:
     args.output.unlink(missing_ok=True)
     exit(1)
 
-log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
+if args.load == 0:
+    error(
+        "Cannot proceed without load address.\n"
+        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
+    exit(1)
 
-elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
-elf.ehdr.e_entry = mbn.loadaddr
+log(f"Detected board {match.decode('UTF-8')} with load address {args.load:#x}")
+
+data += b'\x00' * (-len(data) % MBN_ALIGN_SIZE)
+
+elf.phdrs.append(Phdr.from_bin(data, args.load))
+elf.ehdr.e_entry = args.load
 elf.update()
 
 # QLI boards use v6 sw_id is "aboot"

-- 
2.34.1

