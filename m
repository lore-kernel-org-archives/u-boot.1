Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C58606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xdd1kgtn;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ly1ye9Vf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jJp4YEJx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3279460763;
	Thu, 29 Oct 2026 10:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xzPps77e-jVp; Thu, 29 Oct 2026 10:58:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C73FA607D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271506;
	b=dpWzBOwPzI+wNSIWRH4K/P2ZhIMatF1JfsRQM+f14PkDM0pVk9LtuoUYMYNXEHyozzLG
	 Z6ul2wU86p/GVPk9kK/XqohBTT3vbm2w4WFsV6zyH7MlKqBUUpl133b9WyxY3erJirTWO
	 OML0nsL3jGBFPvx0k65Esvx7JsfWZIWCXTnnt6FmM6RFWfXlCXTK2LxqvS0t4oS/OG34T
	 WZg09vnyn2Oq3a0bh3Zpbk1VYzoY2daB5Rq0rOYT06HhkZ2BUyIi3HJxSj1dkKusH68R1
	 /p7Yf6WGq2CxzUQGbajGGiwQg8XxyUEAOYnd4WhacsntLtqnwLgmeR5RoPX4qz8dcTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271506;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
	b=ERe6Q3Wg3w9vr9Fthfu3Cv5X9rTpDD1CKOZSqyk+35/ima7QJDh79VIwHVnEdW2qCdu1
	 V9eFIC3xevAgeEuv9eb2hcRhuShgdwbAFv4NqzFUdxQCl8MLSwyPaK44RQbhBLpfsBqp/
	 qBf1zEWvcUmcZEeYoEwd7WIn8wl28FZGUQGgR8UX0Xos4dlb/6+HnX/PzAK8OHaa2CTPF
	 /kOHhT8ZCZrNNGvH+K+8rvGUYhOao/bXa1CHJxrDqFPYZKLA27HY/i8ha097Y6fqS9dmv
	 KeRIwsjKnopRP3cTznlOtQMjOS7CRJEIEcg/fK9SLJuDaEjyaA1dXfDMjT8ULPcxgfw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ly1ye9Vf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jJp4YEJx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271505;
	bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xdd1kgtnvRBSlixVkAwWEMX9zqzz1gV+Gh6k9Of5dp4avNyviHm8OH8HFo3TsvZUW
	 UfHVsexvdx5cx30ZE55MsM/luwQlp0Bb2YXxhAvnmKrO6nQL/8Ez8BKTkvKMv1xGnE
	 WZX3t1CCxmLkcNId5UA3WFEbNuraOHbAal6Gq9heOJFveux36Pee5noKDngpwWPsKF
	 pwp0CHpDhXQoezmif1LLx1i+Xh60dB0NrOdLotgUAg8ZCnqNKI+yJ6twFE8oJrdh7i
	 kl0UjurvVn5cspxVJ3fxrAT+NCKnL91jiQe6xImnVrvee/TTh7mwBk6Iy7+RZ9vl80
	 2/qtlwLM0dAOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C73FA607D1;
	Thu, 29 Oct 2026 10:58:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D256E334
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBDD8607B8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ik2EUG-b2jaF for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:58:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DC8D607AD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271490;
 b=TCVDVSVe7+qIFn2np0qkznXLyf3Cib0k430rARYdSzHNeYLpHF9L06/wOebPiYFmyjRi
 Oci1tUhne/C2Bfx5a0mwePkxtRN5p6tAhNdLM5O3xMf1a07PwTStMSzwmKL1c/OSavsfy
 DiViwceNuZnZKHiMGO9z3xishxCIFcgW6KG7lBV669UxU9XSE+qpaC2vdTap+zlpNOJaz
 AHXKjUEzzJK8NqXViPkAOVsTjXLGcTiS4+aw3RiAltVs8pQns5cjGSTWgX8vgVFsGeMNO
 XnYLvJQtr/I1RjfcAk0gkm7QikL6646ugAnWgwKbx2LAfbQFUM8gOi+HqZJezyqCocA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271490;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=duXcHHpZMprw3jcX7HkVJONRrDekzT1LsN+7Dku11rxJtwe4LEH3oK3GizHG+YrYYout
 K1wW20ZN2cZWfYy7AjKn8PGuzh7FMZ00QE/S7zNmhVgd5T3sWS+beSqSWlDpccgHCpt0G
 Ev9GCA4Tj5QWmngeMCUSqZ0jcitLMCMx/Ci8FbOWildHWMMnxB7XwoNbZPnRypv8LGpqJ
 9XiCn4UFNct0bvhN+78qr7Nm0PauFIb9OMfEPSE+D13a382IombTdwaCwhKXO3+/sFFFP
 gfmt7Gq4oHBXbLGN0fDLjXiNGWofrgbLzfmi1/yzKN+uKWyqnHtWi69bvGEpe6a9/Uw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ly1ye9Vf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jJp4YEJx; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ly1ye9Vf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jJp4YEJx
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DC8D607AD
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vDYL2912447
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ru8XYGxifVL
 sFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=; b=ly1ye9VfWZVTFK8JH65KxDWeBm4
 WQCT1A/LCdsL9ksPweIswSfOAjA3c997RkRlkWZDNt+Ncol8CTk5fclSz0McWMb8
 I+B+pDqM4HcMO7RHhYbFgUVw8A9woJgFB4ByZJjxrbFdJ+oGi/E+6Vym5c1cmVe7
 DxjBYMpSd194SGTPjErADFxQU0DmFgapi/XmA44t9HDQPzQAqZWpH/j6QDtA939I
 dvKsObiNtqB4+zaCfBWbB973FesYZmj3zIwOBg8iiqHm0dSbgz3i9j58caFSVxAI
 2bKqKs0/9dBK2Yck0ekw8AUCs9bNYT+5hzCK/Y18y5aTqddCYssnTojyOwA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb2bm8y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:09 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a2f2ea3c3cso3050209c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271489; x=1793876289;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=jJp4YEJxSz1eNybAA+h34cnTqSNY9GrH22/XUgkhqCHnw/xBhuOYfgbFGfKSLKg3iN
 ymzZCs8RxBgANt5G2Pyg2J/7xJ+AMcqfIQ6S2Eu3QjPrsjCBWexNnmnuP7ENOLp5WFUY
 4u70nnPjldlmlVmEJZr/UBJM4I6YV1cEWxpWxyt0Li/M+Fdy+lmFfP3mEBPDRq/bNdiU
 s88inpm9PUEp+i+sT9Z+t2TtobWaewhmy4TVqPyYdD9KtaKgEkPT8hpd+D7A+5Bnb7yz
 KKr1J4UFs/86It9eevd8ZaPWodoBOo7WuZz6+DJZdid7b4fzr+tDYTbIpD7p9gJzm7hd
 DnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271489; x=1793876289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=hdUI57rbUia5LUfWAIDt15LNq/sw46hxRYYXNd7S+KPJD5Qf9iaqLQkYx8M/Xt84n8
 HVIXSiZOa5K9BH4SJVO6Ut+2vxTunZzKe8CJjal8WmnobZOZNVZMxEz8O0fzxTYE33WM
 ezzF8F5ud/IclZ/+KnstD6mM9UMrtW3kv6BSUmq06+179Qo7mOjWUBVWfQpt0ir+n41n
 HtCSD+WIdS2fcMbdZmJpeVuXw3HI16EIAmtnNCfn7D+OZSIWa5QAtTnQcciykxg98JCH
 5rF0/OkVUX94C17snn36Ks7mjHBdCMk2s8E6QHgffFOnLwwblgwzegciJaz/OIVFgnmG
 YkzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYisWBRpn+SGhKOQFnvNsksliBT/N5RSXf+aPgd5ArIa2w08DO0OHnBdQVjS8m5t4jtkt7oOE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLAZU9oNuhROpN67TImhDC5tvbNGeeNmrFYxyE+ToN//5qGKQZb
 HK1aErpBQgr9typkNeU+4Flh0gh+eONcCKLArw75LgvLpO7nTFQVembR/8iYvHDhvqPdJwBnTTf
 hBBI18B2BcrIuk90xVpv0+SygaimtnvbPVEr9ahzWYlM8Krvq01nGy67YMjTT1WKteWIIvuU=
X-Gm-Gg: AYBFou1nK4OONdjT54836p/IZ27xynCShwzFS9LE6gXZwNQVU4qbDvChuJUL+RTJiW+
 vAJOQ0IR7Y4GlihWSSZM7KdLMsNQJqZtU+9FzwwdLd95r9I8SW6lXOoSIAZz8TA+nNxqh5Zv62a
 HY2WzD1tgLg3e8Ld7pZRYHL2ymqO8ZrCyTSXBuagmDSHG577KRi87maIK3/WYIiI6JfLGM9xe+s
 cfEGR/Tqrri0x2qc9u+qHVapoGSjoArHxOxhuV8EUXo/K671Z3PVSNvSp1WvGa2jArJaSafHmri
 Sv0PmX5rsj5s0gyVQsBZsJDhJThPBl2h7zBpnIlGcpg0+s8VU1iJ8je/zitVNYIFQOMk7UHgvwO
 dCeomdSuGHzp2Kt0rlKW7lUrs5XQM+obexQsag+qvrdzZPYbAWnshJpWfzi8frx9zJEC+UQl4an
 yXRbL5oYpgqKAwFWtEmlckzQ==
X-Received: by 2002:a05:7023:90d:b0:182:94d7:f76a with SMTP id
 a92af1059eb24-1a6cfa0e86emr8033418c88.43.1793271488235; 
 Thu, 29 Oct 2026 03:58:08 -0700 (PDT)
X-Received: by 2002:a05:7023:90d:b0:182:94d7:f76a with SMTP id
 a92af1059eb24-1a6cfa0e86emr8033378c88.43.1793271487591; 
 Thu, 29 Oct 2026 03:58:07 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:58:07 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 13/13] clk: qcom: build only selected clock drivers in SPL
Date: Thu, 29 Oct 2026 03:57:46 -0700
Message-Id: <20261029105746.3487456-14-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae326c1 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1OAO5j4Zegv94xHJGxAA:9 a=yafjnGloKYvRJXMp:21 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: LRspBis0TdTH1Th40ympBREFiUBa-zKA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX+LGMm91THERZ
 QyeNhacyu7/ixpXkSdj06YmUQ3y5jJ399r4gSzAu7TqD/TDdp/tu8rlEpFxTLrDgESCIM65ZIJV
 MpTwbWdwxY0cxS1RtzsFX/QB5H0Bmpw=
X-Proofpoint-GUID: LRspBis0TdTH1Th40ympBREFiUBa-zKA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX6Vq/CGewrOuO
 87K8wMxHWzOX0cjQerMpgRRHnW8JbwBYv0l7ZqbLM2c20gaXHejiHqQrTcJqzyHQqCxUqYcxR1Z
 bGotep2NxPXpWh5zLsruxzeuaonuO/HVHYZtPsj2AH7+7b9wYwof9be7dAoVfuFIFeHb2MyfcSx
 Ca8riUBjs1rE0mm4kSmlp/zh8JfqriPsoAb7Ug8A2pgyw3XE8RNne/OpvBpFpxiIp8n2hB3J7yv
 FEULzvGLaIdkI4xc0XWrvNmryYVWdMbyslaEBUJNu/rsIck28fTZom5jp5/IJACwI4YSoq8/stE
 2Jow5hCohPJFAPbu87ni5ml/a27k8+LI1tHrq8ghrRQZSScto0ecMCoqvjziQrQd4r1yCX9DF+D
 bZiB+rV+jN9S7k4X1INVbPy4Lpp2eKE3pq6AnJ15Q9h7p7tTtez+fIhBQJv0uL0nyB+SwrjbQnC
 hXWBV/AX2szncId7RbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290042
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Make Qualcomm clock-driver selection phase-aware so SPL builds only the
drivers it needs, reducing the SPL image size.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig  | 208 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/Makefile |  48 ++++-----
 2 files changed, 232 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index aff3f5418a0..899f44cb8dc 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -5,6 +5,11 @@ config CLK_QCOM
 	depends on CLK && DM_RESET && POWER_DOMAIN
 	def_bool n
 
+config SPL_CLK_QCOM
+	bool
+	depends on SPL_CLK && SPL_DM_RESET && SPL_POWER_DOMAIN
+	def_bool n
+
 menu "Qualcomm clock drivers"
 
 config CLK_QCOM_APQ8016
@@ -15,6 +20,14 @@ config CLK_QCOM_APQ8016
 	  on the Snapdragon APQ8016 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_APQ8016
+	bool "Qualcomm APQ8016 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  SPL variant of CLK_QCOM_APQ8016.
+	  See the help of CLK_QCOM_APQ8016 for details.
+
 config CLK_QCOM_APQ8096
 	bool "Qualcomm APQ8096 GCC"
 	select CLK_QCOM
@@ -23,6 +36,14 @@ config CLK_QCOM_APQ8096
 	  on the Snapdragon APQ8096 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_APQ8096
+	bool "Qualcomm APQ8096 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  SPL variant of CLK_QCOM_APQ8096.
+	  See the help of CLK_QCOM_APQ8096 for details.
+
 config CLK_QCOM_IPQ4019
 	bool "Qualcomm IPQ4019 GCC"
 	select CLK_QCOM
@@ -206,6 +227,193 @@ config CLK_QCOM_X1E80100
 	  on the Snapdragon X1E80100 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_IPQ4019
+	bool "Qualcomm IPQ4019 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ4019 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ5210 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ5424
+	bool "Qualcomm IPQ5424 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ5424 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ9574
+	bool "Qualcomm IPQ9574 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ9574 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_MILOS
+	bool "Qualcomm Milos GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm Milos Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCM2290
+	bool "Qualcomm QCM2290 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCM2290 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS404
+	bool "Qualcomm QCS404 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS404 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS615
+	bool "Qualcomm QCS615 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS615 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS8300
+	bool "Qualcomm QCS8300 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS8300 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_RPMH
+	bool "Qualcomm RPMh clock driver in SPL"
+	depends on SPL_CLK
+	help
+	  Enable the Qualcomm RPMh clock driver in SPL.
+	  This provides RPMh-managed clocks needed during early boot.
+
+config SPL_CLK_QCOM_SA8775P
+	bool "Qualcomm SA8775 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SA8775P Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SDM845
+	bool "Qualcomm SDM845 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SDM845 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SHIKRA
+	bool "Qualcomm Shikra GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm Shikra Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6115
+	bool "Qualcomm SM6115 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6115 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6125
+	bool "Qualcomm SM6125 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6125 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6350
+	bool "Qualcomm SM6350 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6350 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM7150
+	bool "Qualcomm SM7150 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM7150 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8150
+	bool "Qualcomm SM8150 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM8150 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8250
+	bool "Qualcomm SM8250 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM8250 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8550
+	bool "Qualcomm SM8550 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SM8550 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8650
+	bool "Qualcomm SM8650 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SM8650 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SC7280
+	bool "Qualcomm SC7280 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SC7280 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_X1E80100
+	bool "Qualcomm X1E80100 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm X1E80100 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 8da2ff7e73e..7c4db9986d1 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -3,28 +3,28 @@
 # (C) Copyright 2023 Linaro
 
 obj-y += clock-qcom.o
-obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
-obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
-obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
-obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
-obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
-obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
-obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
-obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
-obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
-obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
-obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
-obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
-obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SDM845) += clock-sdm845.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_APQ8016) += clock-apq8016.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_APQ8096) += clock-apq8096.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ5210) += clock-ipq5210.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ5424) += clock-ipq5424.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_MILOS) += clock-milos.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCM2290) += clock-qcm2290.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS8300) += clock-qcs8300.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS615) += clock-qcs615.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
-obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
-obj-$(CONFIG_CLK_QCOM_SHIKRA) += clock-shikra.o
-obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
-obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
-obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
-obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
-obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
-obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
-obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
-obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
-obj-$(CONFIG_CLK_QCOM_X1E80100) += clock-x1e80100.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SHIKRA) += clock-shikra.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6125) += clock-sm6125.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6350) += clock-sm6350.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM7150) += clock-sm7150.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8150) += clock-sm8150.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8250) += clock-sm8250.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8550) += clock-sm8550.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8650) += clock-sm8650.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_X1E80100) += clock-x1e80100.o
-- 
2.34.1

