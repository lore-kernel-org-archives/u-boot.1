Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4872606A31F
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ahGDjfo/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f32+gJBW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WdIahLYK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8729E6068D;
	Thu, 29 Oct 2026 06:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9X6d5kt8www; Thu, 29 Oct 2026 06:24:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92B0360697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793255084;
	b=a7CW1yj4+OJpu7Mpsfq8g8L2xsCUga8u1UEhq9AQmamHJ5ujddQOqsbpZ0aa5gJwgJVf
	 jy8hjGwcJDc+yNJAfmgIIq2UMRdOFGRFyE3RyYZc+N0Cf3mXY+pPPu7JUENHlN+xSRuDY
	 eiFno19YrzcE5KpjdP7tcdUCuaUHUvq4Qq54iDIE1M9o5LDMhgDO3sTwa53ss6WQNQDFI
	 kNQGgHiC5CZUK3XogGKmDlgHe4DKZ6sZEnvSiEa2JsmrjOyBgTH1U3FxI+PIZnl/R03eE
	 enhC5oAM8NvN5VpVMUhZiTAyQF+Y6JglS4d967Q6iHRw273YW2mewaWLZC89aJ2uFBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793255084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sHIvYDflPX2axx+3M9vSn/5UqjO/1elt/Z0rqFgInWs=;
	b=RqhK3w3pdzAsXzzIxYZgTP6CE3s35RkG7vuP5NuCk1oDt5pZyXH6HPvnaj4voFDOJ4aD
	 fSJgv1kUMPBsoU40M4ZGGEctAFYJ0Tg6ePtGW/s11BKQuonu9ngqT+DYUPkZGJ15L12pr
	 3P0cdkn9HZdyxmQY6Ft34oRBi2y/fupdJrq6bBCjU7rmJ8EnwwXfINAbKfYT4Cl+5Umx+
	 Z7s68KHaCjzLSAAz6+WqaZIDZv+JCQFFAyfdJIr2uwfWPjN6IE9IFufANqPILziAUjkBR
	 F0fKj4V+7SjwBxADotsyvSMZ8XTU6dUC3iSbX2m0lyRGFe3XVDSubF9dcXfBHDf2/hw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793255084;
	bh=sHIvYDflPX2axx+3M9vSn/5UqjO/1elt/Z0rqFgInWs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ahGDjfo/HKTUyd91OMy51VjAf241Y+1OKz7tcjFHVnxcjB/JOTaMyGfNzlDoNfcxG
	 EwQ9he2aAJ8V/hmgk7J3Yxa/H5LM5Bxj9sqEBnQhGfvFsRUKwFrXDJt5APQ5zSwwKc
	 E/57FJmwdUIXmWypGA6MK0IKSEzycHK3u1/2sNqeEPkWsd79dNZe4+Dm7oaZdVivyA
	 nXGdFCJNsAHo4qmViKlwQ/WEMaqzgD2RnKUOptJhJf1ibOZl+8JzUO9qgshjfwaf/b
	 wFoXcve3O3HXiCKeUJj0IXQ1m4D5Eoe57aVak0eAdSlrSUhtPYFHjcx99SzB1kmP2S
	 6EtphWZPh4hFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92B0360697;
	Thu, 29 Oct 2026 06:24:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13898235
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDC174032C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJk-iwNNJfU2 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:24:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C8A1940176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793255082;
 b=IxSC0TQ1Q5LnIlrWTwTjfpWgTB/r2yLCK/Y7N5J+KprofUjXMljeK371zPZ9mieTHocL
 DBkmevyauTLSkjj8MXfjZRNyXmKTs2ma7bbr1QyR14ziX9vwpjw/aBGj5jJjAWmQ3MrYJ
 pWK9G14uDzlhKsJxlPAu0djcqnO0BGeh2TAZe9tcLd0sGM34WGIcs5XbT/XDtJUwXf5K5
 +ee0Pt7o/hO5fAVPD86Q2iFsT96b9F6SXudOi7hvvCf9J355bNMSjWB9UaDvimAPJuzJL
 BeSXpN9HqmtucRzGsZ3HjNpkawn4LV0mo9uBkEVDUI/WDB8HAmw5XFa+s0W8c/bscLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793255082;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=sHIvYDflPX2axx+3M9vSn/5UqjO/1elt/Z0rqFgInWs=;
 b=A3+L0ugKyEmDcTwK2myJANRJ0ri8C6b2vH8JWgWpIdnHCflijm/76WDOtv4gjik/7pVN
 REO1o5U6aSGo1QjNbR1fCw8KEHCCyRrtGZkn306hzK5EOOYvNf/38MiImmK5OPpXJZa9d
 G02DXMoZ3onCpeUyPMrRkI00+eZdjSx/0X+ip7FZ3DeTtVGiL0TFL7jdRowcWlwJG8wtk
 3In8AjBDCwRwFsQlguWVwbBdYS63zy/C7dAoP85DrYaDeTA97LHNDBAdLv465KDl56jdy
 XLZHDAk+gYl8ZTWEWvfXLjlKCA5ruxCPRP/bo2P5eGabp+vl/c12gm/CFVddTxUVPsg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=f32+gJBW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WdIahLYK; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=f32+gJBW; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WdIahLYK
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8A1940176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:40 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5H69m3282398
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sHIvYDflPX2
 axx+3M9vSn/5UqjO/1elt/Z0rqFgInWs=; b=f32+gJBWhl9pmV0ljHs1TDPq1E8
 lJQ4AXsZJLXtonmlNdh39Kjny/tAzXl9Z0QpOdiLYxRqT54UNtJh8vgJnsem3Un5
 73MzEZEKFe1HEjJtfy+H7oIjedk5pOMI+9Mqz6H9g6Iexg1dHDPFrYMTpBgalkcz
 4iE4svPwkVuaWJoqnBDGMNvX4lS9hw0SyOlznNV/dE6PRoTLxWaPs9NY7k/ToOqF
 LVZi7EHZJqFs1J/seQqKuhw260KNub7+Ykwfy19IpPmxnwMe98GHQ70R+wxs7GIo
 Rv0Zl13HM7hT57IYnqHqFODnLarz8zIKDv8VeZ09woMeOfnsoX1rcqHuR5A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgpt7ab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:39 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a5005fd0f8so1822244c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 23:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793255079; x=1793859879;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sHIvYDflPX2axx+3M9vSn/5UqjO/1elt/Z0rqFgInWs=;
 b=WdIahLYKWpIrdNeQkqMDYOZKEvnu6wbKXzAN/rVQZQK3UN+pQKZ+SPbeOjo8nbzZgA
 LyLTeQhh3b01s87YIsnrk9z6WHp8lfFP1IWoiXoNUHaFQb8+sV0bm/aRJtt6my1SWAQE
 wTC+YlndxM8Y1jnE7BeLJnD22hva90C4jqTgK3r/4oJ8pHDvDXen0nM8w/KxtM7frMCP
 cA/P0jJAPLyXrcnyyZmitAKetKdwOkhtdjAW52Lq7y9nLYq8NwDZoPP4o4zCisji7Isu
 BPkt13qSQzhtfrANQEK4ULw4qu9RISUpIiLueyp5nIpcehqRSiCdiYl+CcdHbFtLXQlD
 ANhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793255079; x=1793859879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sHIvYDflPX2axx+3M9vSn/5UqjO/1elt/Z0rqFgInWs=;
 b=zsXk1CSoJp278Rys2/KOQSiqKsoY8RWvEj00lfQIPmv71yfNT9qUeIFk/r/LgYda8N
 2KjZmimiLl87aTZC+ccDvBevn14a8sN8fInXAAmx9mkQBPNYm1CyB2dpZdQ1EN/73Wvb
 VJLOp6KBdPc9J0KZJYNo8V1qmYfCxgo5bZ32tQat03DxFx8d1amL7VS1MLIr5jiAguvG
 BHhLFbmP65HsGkFu5U567aH5vGQDb6Dc8lyPVRc3PVgdyemxFFm+qesVZNeFFB2nQVj5
 KTZUlmLSW9r1HTI/Y4jwE0WM48LayDSnJ8y6w+LFmrV1B7A4UJVlOeU+O62nY/xFe40t
 o19g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9YSm+U0aw76X9qEtiPxtc6dzI6MrDJeQeJLcQjbhrraAa5pA2/VRb3S1QCUOFvtIhAuQcIgE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIipNF2So6ipbhW00CONhCRkHXi+RReNZ3tnAEu951ZduXuJAxx
 wYlvUxknUX4CIlhj7vmKD0z+eeZYtn362A1I//Ioz/Xn4jY2HtnUUOItS/A6NCqgKIyKJIkQiRf
 PQuR1D8Z7iOd1xuRHOcDItnh+ZHaKdCKXmvhHT2S9LI0gC3S+rV0nv8GmiBe3jdbftKgOvyo=
X-Gm-Gg: AYBFou0jHCizt91DwHNd8wGDEwuOkT05PrKhRdgn3HsdN38HcnIzfu530sCLxemNZIs
 VHgL78Y90FSAVCkWRJPKRmAVKIDlwZ6CEFOqOQMx6tia6hFkoHFXlf0m7UiMuI2Jjd0tQryqNS0
 JK1e5LVnTB5twTxo0HUe9uNuBQ5j2bvrTJE/T0/5U5gHU/V5cobCEIvEEybjs9NmQ1KxPw1N8EO
 dMG/KsLJw6VEQNl0wXooG2hE+tSfwCb2G24nOC/BxCgBsbAj6KBdJv8op4V1pL/nhJdvfE7LSqF
 +k59VDHCWJqyKqZ5YlD2q6KAGJqH3gENjmGDVcpgpfiTMEBK2nhi9A9NcuoAIqhJEivB68YrLZQ
 5G4dLDtnuL95fU4lY/Gt5JUZkGkWWT4xaB0/w/tkW8Ii3MWjoOLraw99EUV7+/9vJKo0aKr72/8
 YRZ216mDWoqlW4HW/Dpwk/DQ==
X-Received: by 2002:a05:7022:ea8c:b0:186:4a57:94e5 with SMTP id
 a92af1059eb24-1a6ce4ebef6mr5832839c88.34.1793255078532; 
 Wed, 28 Oct 2026 23:24:38 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8c:b0:186:4a57:94e5 with SMTP id
 a92af1059eb24-1a6ce4ebef6mr5832801c88.34.1793255077841; 
 Wed, 28 Oct 2026 23:24:37 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75a5594efsm16125714c88.2.2026.10.28.23.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 23:24:37 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v3 1/1] cdt: enable CDT for Shikra SPL
Date: Wed, 28 Oct 2026 23:24:31 -0700
Message-Id: <20261029062431.3117727-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029062431.3117727-1-abhilash.v@oss.qualcomm.com>
References: <20261029062431.3117727-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX9SFUB3vZLrm+
 4e0qoY/57b3V6bC5PHp8k1nozL7Zk2vQxbovlfDBJNGNND3I+6PqfZCu3QMPk51YHogqGrjyKC/
 16eFnIAGk3br2GztAFxHzpwXCjYGqwkj8LrbBWo5hdTJ05Yk5Ym2Y8M7qf4TLT9IOHLtdWH4uCr
 MrfF/YXG35+FrCyl/LJxtL9EKjDx5LwZo82q2i0MOUjaz6smc+bsV6VPH9PX25KfRWXO8CEH519
 wuQaGeuveL+o9tQMqeVJnsbWFizxeIOjlri3OzenZEX1aU1djJBTBqONtTQYxH/xbN3phpMRw/g
 WwudrtYP/uTN3XUkkJDO8LfwKCyhAQK66FPviTpT+taT9SG2t0LBWETimZIjMRzB/4dxCXrfxl+
 reiwH4Ffi+dESNOJkl/QiQUzM/qMwqVD/OqLutxz2IfLEvg+0K5z5t+LuDwaixk7/nfZecguhKO
 iI2BzCekdOfwp2a4jZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX6b3CU0Ttbt90
 /oMiGw1s2IAhEQWu5/yT3ZYFsxd84uehr5a2i/lsOf8NkIrIFDMUAhJuVQOvAvM+4JeQfN/8iAt
 DML3FKGb7BXps+yTUKW9qqEowDpWuPs=
X-Proofpoint-ORIG-GUID: ooqOb_iXSiffg3bkRmHYokJO9g6KULQd
X-Proofpoint-GUID: ooqOb_iXSiffg3bkRmHYokJO9g6KULQd
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae2e6a7 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=8Dc65MydYGbk5yE76TMA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290024
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>

Add support for loading the Config/Chip Data Table (CDT) from eMMC
during the Shikra SPL boot flow and registering it with QCLIB via
the interface table.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig            | 73 ++++++++++++++++
 arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
 arch/arm/mach-snapdragon/qclib.c            |  8 ++
 board/qualcomm/shikra/spl-shikra.c          | 10 +++
 5 files changed, 188 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 9e23d6d8948..7f5a9eecb7e 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -76,6 +76,79 @@ config QCOM_HWDETECT
 	  Hardware parameter detection from SMEM and TCSR for
 	  DTB selection and other platform subsystems.
 
+config QCOM_SPL_CDT_SUPPORTED
+	bool "Enable CDT support in SPL"
+	depends on SPL
+	help
+	  Enable support for reading the CDT off the boot medium during
+	  SPL and staging it in IMEM, so that QCLIB can pick it up via
+	  the interface table.
+
+if QCOM_SPL_CDT_SUPPORTED
+
+choice
+	prompt "CDT partition lookup method"
+	default QCOM_SPL_CDT_USE_PARTITION_NAME
+	help
+	  Locate the CDT partition on the boot media either using partition
+	  name or partition type GUID.
+
+config QCOM_SPL_CDT_USE_PARTITION_NAME
+	bool "Look up the CDT partition by GPT partition name"
+	depends on SPL_PARTITIONS
+	help
+	  Locate the CDT partition on the boot medium by its GPT partition
+	  name (CONFIG_QCOM_SPL_CDT_PARTITION_NAME).
+
+config QCOM_SPL_CDT_USE_PARTITION_GUID
+	bool "Look up the CDT partition by GPT partition type GUID"
+	depends on SPL_PARTITION_TYPE_GUID
+	help
+	  Locate the CDT partition on the boot medium by its GPT partition
+	  type GUID (CONFIG_QCOM_SPL_CDT_PARTITION_GUID).
+
+endchoice
+
+config QCOM_SPL_CDT_PARTITION_NAME
+	string "CDT GPT partition name"
+	depends on QCOM_SPL_CDT_USE_PARTITION_NAME
+	default "cdt"
+	help
+	  Name of the GPT partition on the boot medium containing the CDT
+	  (Config/Chip Data Table) data.
+
+config QCOM_SPL_CDT_PARTITION_GUID
+	string "CDT GPT partition type GUID"
+	depends on QCOM_SPL_CDT_USE_PARTITION_GUID
+	default "a19f205f-ccd8-4b6d-8f1e-2d9bc24cffb1"
+	help
+	  GPT partition type GUID identifying the CDT (Config/Chip Data
+	  Table) partition on the boot medium.
+
+config QCOM_SPL_CDT_MMC_PARTITION_NUM
+	int "eMMC hardware partition containing the CDT partition"
+	default 0
+	help
+	  eMMC hardware partition number (0 = default user data area) on
+	  which the CDT GPT partition is located. Ignored for non-MMC boot
+	  media.
+
+config QCOM_SPL_BOOTIMEM_CDT_BASE
+	hex "IMEM address to stage the CDT contents at"
+	help
+	  Address within BOOTIMEM where the CDT contents read from the boot
+	  medium are staged, to be consumed by QCLIB via the interface
+	  table.
+
+config QCOM_SPL_BOOTIMEM_CDT_SIZE
+	hex "Maximum number of bytes to stage for the CDT"
+	default 0x200
+	help
+	  Maximum number of bytes read from the CDT partition and staged at
+	  CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE.
+
+endif # QCOM_SPL_CDT_SUPPORTED
+
 config QCOM_TMEL_ELF
 	string "TME Elf to concatenate with U-Boot SPL MBN image"
 	depends on SPL && QCOM_GENERATE_MBN
diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 31a06b1e002..ea5511689f7 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -10,8 +10,12 @@
 #include <dm/uclass.h>
 #include <hang.h>
 #include <init.h>
+#include <linux/kernel.h>
 #include <linux/err.h>
 #include <mach/qclib.h>
+#include <mach/spl.h>
+#include <memalign.h>
+#include <part.h>
 #include <spl.h>
 #include <soc/qcom/smem.h>
 
@@ -38,6 +42,98 @@ void __weak qcom_spl_soc_rpm_reset(void)
 {
 }
 
+/**
+ * qcom_spl_cdt_load() - Load the CDT from the boot medium.
+ *
+ * This functions read the boot medium for CDT information which gets saved
+ * in IMEM location.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_cdt_load(void)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	bool is_mmc;
+	int ret;
+	void *blk_buf = NULL;
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_debug("CDT: boot device not supported for CDT staging (%d)\n",
+			 ret);
+		return ret;
+	}
+
+	is_mmc = desc->uclass_id == UCLASS_MMC;
+	if (is_mmc) {
+		ret = blk_dselect_hwpart(desc, CONFIG_QCOM_SPL_CDT_MMC_PARTITION_NUM);
+		if (ret)
+			return ret;
+
+		part_init(desc);
+	}
+
+#if defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_SPL_CDT_PARTITION_NAME, &info);
+#elif defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_SPL_CDT_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_err("CDT: partition not found (%d)\n", ret);
+		goto restore_hwpart;
+	}
+
+	blocks = DIV_ROUND_UP(CONFIG_QCOM_SPL_BOOTIMEM_CDT_SIZE, info.blksz);
+	if (blocks > info.size)
+		blocks = info.size;
+
+	{
+		blk_buf = malloc_cache_aligned(blocks * info.blksz);
+
+		if (!blk_buf) {
+			ret = -ENOMEM;
+			goto restore_hwpart;
+		}
+
+		size_t read_size = blocks * info.blksz;
+		size_t copy_size = min_t(size_t, CONFIG_QCOM_SPL_BOOTIMEM_CDT_SIZE,
+					 read_size);
+
+		if (blk_dread(desc, info.start, blocks, blk_buf) != blocks) {
+			pr_err("CDT: failed to read CDT partition\n");
+			ret = -EIO;
+			goto restore_hwpart;
+		}
+
+		memcpy((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE, blk_buf, copy_size);
+	}
+
+	ret = 0;
+
+restore_hwpart:
+	free(blk_buf);
+
+	/* Restore the default hardware partition, if eMMC. */
+	if (is_mmc) {
+		int rc = blk_dselect_hwpart(desc, 0);
+
+		if (rc) {
+			if (!ret)
+				ret = rc;
+			return ret;
+		}
+
+		part_init(desc);
+	}
+
+	return ret;
+}
+
 /**
  * qcom_spl_get_boot_blk_desc() - Get the boot medium's block device.
  * @descp: Set to the resolved block device on success.
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index a32a85c48fd..ed3e5910e7a 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -12,5 +12,6 @@ void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
 int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
+int qcom_spl_cdt_load(void);
 
 #endif /* __SPL_H__ */
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index b9a74863c1c..5466fb3754f 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -123,6 +123,14 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)) {
+		ret = qclib_add_iftbl_entry(if_tbl, CONFIG_QCOM_SPL_CDT_PARTITION_NAME,
+					    CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE,
+					    CONFIG_QCOM_SPL_BOOTIMEM_CDT_SIZE);
+		if (ret)
+			return ret;
+	}
+
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
 
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index c2a5d2d692b..94d005f65ea 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -12,6 +12,7 @@
 #include <dm/uclass.h>
 #include <init.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <malloc.h>
@@ -333,6 +334,12 @@ fail:
 		reset_cpu();
 }
 #endif
+
+/**
+ * qcom_spl_soc_qclib_override() - Populate Shikra-specific interface table.
+ *
+ * Adds Shikra-specific blobs/entries to the QCLIB interface table.
+ */
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
@@ -383,6 +390,9 @@ int qcom_spl_soc_pre_qclib_routine(void)
 {
 	qcom_spl_soc_shrm_reset();
 
+	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED))
+		return qcom_spl_cdt_load();
+
 	return 0;
 }
 
-- 
2.34.1

