Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3E606D578
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zG8qFMM8;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pdZ3XU+3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G0RC4KNr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72CEF408F1;
	Tue, 20 Oct 2026 16:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ud6CZBDXmppm; Tue, 20 Oct 2026 16:47:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 490F5408D7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792514861;
	b=tAXTmOR5f+10v44/Ygwi/LUWJ2u2GDWhS1rFDrTALwRalCK89KeFVKyNIAk/3ORzJKML
	 UkhiYNj3rpWa8Ubm+kwv/Fqth8kalfnmnFvnfrSMgUnb3UCzyE+e1g4ua/MZpr+aLhTG6
	 IPq8v5ca5oR3ed77FVc8FkK+I71QQnekd4mY2J15UTVCFr/ieDuxb/xi8TH4gJ0nOXDSp
	 nqJ84k3rZj9rXp7CLpM9GRpNHRe+FJ/Mg+BCmQUqg+naWXGKOKj0CdK+n5dHH15g252oQ
	 ZPeYPRswSU7zAudTmJVZBwqNFwkAhHLA4LrcgevyoUHuYnJ20YmgIaGN2qnWDxdHytA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792514861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4JOLNm5AuXj/eKZgCFHD3MgY9Gkt3Fb/Y33Xag4kKWM=;
	b=WgdWx1Tva+hLCA4GNgvwZW84K1tew64JIxfNlUQyK7cmyDG/7QZeVZ98t8SPFmm8Dkwv
	 o5sCSltjoc3C14yFW0CMY0PaJrTjUYKVeOs1/ZhorrSr9W0t2I7aOou5TOkriE7S804Fa
	 mNs/5i20hhfFBIWfnnnCjVOdcNh/OUFZ0eE9cx90zfPDQBoyR/xlJnrlXmihHnNcuDyYm
	 JsIWXFQXOMr+JrB+RLA2oAC4P88rHP78cFAFYlniJZGK1pn+ON7qpVfVbu95/eiWdQ4x8
	 z2lTwh8gz/o/YRa/aE0bbOl8YJeUbBpnxLbLN4oQF8G3yI/1n1vph5kCNPQMD9BWPXA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pdZ3XU+3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G0RC4KNr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792514861;
	bh=4JOLNm5AuXj/eKZgCFHD3MgY9Gkt3Fb/Y33Xag4kKWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zG8qFMM8WPR4BTVS3Nx1k5l0Ca0CucBronhC0oSCky/P4iP2ZZuYmHzwfojeAaomw
	 37TfGopy5+FjSytYnidHQKf3csssvjqnfytdKrw6nD1EanIk/jI5o44F6ZteLV6v3I
	 aXIzLWOkqikZN4FjmdV+qEIZZ5PE63HGySkiVyssz3XFiVYoXJxB919Mnf1tgvsWJA
	 FKDBQcGERMIy1W2rbjw97ps8w5KPobh701eA89tRDBgO1crXiG0E/JZ3c6/2FaKSEH
	 49yVDjI9BPN34sAv7CAb8HYoFILdTYD1c2dExa6lJtgw121j0+QOAWmoXPIjXfp/gS
	 VnSc7dePLTYDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 490F5408D7;
	Tue, 20 Oct 2026 16:47:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D53CA3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6A434080C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7B0Ixkwc1UD for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:47:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA871408B3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514859;
 b=Juduy7TEZ10bSaBsKGUk4lPwJGzd4ojPZeyJt15YbBBkSaL+z8TR2XYFxDadlHN4wxpO
 g5+rjtVgxNK9NtINk/S7LdEe4R4biKnEdhOS7QKBbSys8XRZoByxcuA2VCG4l2tLTVKxh
 65Dx8LpyQ2GXgESch7zCwBHdIJB1PkVLugUIMZ2aK7UMi+sMsVHscrHNq9T/c06xGwF7k
 AkwH7XmE1Uq68pzl1Tn/o+uOsPdTYCD/DaYs5GFAnEYeTGLcvvbHR14iAqJE4YU1HgHDD
 1a3u9Vl5/9vZrFdyr0g8JzQ5qfCetu4pWuW+d2Zw+kyzNMuYZq9d+EmdCd3/nuibiKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514859;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=4JOLNm5AuXj/eKZgCFHD3MgY9Gkt3Fb/Y33Xag4kKWM=;
 b=KU3DK9EievErGdel3DZap41pzmPZzCLTq8+xMT9SeKaQemtLJWCUADoy2qTIaHR0g5l4
 PirI9Ah9bak1VT6aRjf6XZM0cfQRqWE4j3nobEByO38LwvXed3bupYLB8DBeZYGSbaox6
 2L9TL0sWN3jt+3o7gt2IFZ2eh/wZbzZouRxz/r2DmQ7/NvIj4TY6vYsA426f2zu2AMSdM
 KPOIxXEFIXWVJMsG0mRGLQ3F72EKW0ay+MxIOXjBkpJxckPm3X4K4zIcp0nhOAGeJoMfg
 bZnVxtUf1hOEA8SgoKrpsnx5ugf81hIwvoMF2/Np5kHOLeVlXoyNovtbFTvPXgCA+nw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pdZ3XU+3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=G0RC4KNr; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pdZ3XU+3; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=G0RC4KNr
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA871408B3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:38 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDAEsg1429985
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4JOLNm5AuXj/eKZgCFHD3MgY9Gkt3Fb/Y33Xag4kKWM=; b=pdZ3XU+3nlE4u1JN
 fgpuWde86XJrIaL/OFwOTcsNeq6ufsInt72iXvbpjSXRBL9TCFUpo/8uRh06oRpz
 0BL7itlmuh2PSlK09POtfqq41nfLPBd/LvU4tWSdesu77l0O7k71dCXSHVpoOsAm
 Oinu33VtT6f6meqtNaWGoVPBsPCvxi3ntxfe9rjYDRvyOiNm3l2jBPcRG2SW8+dU
 Gc/KXgC4oeIwayJJxZ69eK9czQLTbvNDVGxO5IYoYb7pJY3YapPWKnYLp4+qrGMl
 whtnYyCKFyhQ56HMjxmUDS1U3f758wYsEAD3PwCLiJHY8ddusH0xuEcFoqbIA5mC
 OajIsQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qbfch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so7495667eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792514856; x=1793119656;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4JOLNm5AuXj/eKZgCFHD3MgY9Gkt3Fb/Y33Xag4kKWM=;
 b=G0RC4KNrb2k5vTmSVLVq6c14NeejZX4YReh+hylag9MckRHJbJxkFirvJL+149Z9cv
 Ac139jXDquYp2elDuYb0K4xz4ainWO86m+Ff1+hbzXbvYkJC3w77VpzZTjXDBMEk1jmB
 BOAOeAffOL7MMJim5O5iCgRMgy0Y+HlTijBX730yfAMfko5ooEKkNkdUH6Zxqgx3pIl+
 QnIx+m21kUDrx240DAuDg+ruHKLDa9p8UyKRxxfhTiIjIXUJWxYwdbwiY+hN8vZ+xv74
 uVIagJpLpXND4ZViSUWSt7O/mpteWVDL6SrzmjmgNE+ge1TkoXT+LzVRmeZFznx2eInn
 8HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514856; x=1793119656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4JOLNm5AuXj/eKZgCFHD3MgY9Gkt3Fb/Y33Xag4kKWM=;
 b=GsFAsNjwjkmkGazRSvY+K3Jx2UPbNC5b+qDzgun/ThrDFrvcm0ds+0+3OObkPyYvFV
 fhXGLMWkf63RN+3FQMom0zH9dVak+sYmlxUWN8eCn1gnxnL1REpgxpJCFPX70T7oB+VM
 WW85FM3KZGY8G3FHBZHIG5AW3I+svQCBb4YIrjg9rz/xyhL/vYYaPjv/c19DRjXPbKzH
 +jt5FbN4ogxInsWS9buvJIv3MVS/oEx2yyvHuciCwKc2JZnON+wKnsVeLV57SYofjfkl
 HngmfdDKLgZOOemuR+2PLlfoKwW9y/d5ZhHtZj2eRnNy6g1cCzpYiof1P8ro2G89nSEW
 JGOg==
X-Gm-Message-State: AFq9FYJGHbzGLL3JrYq/NFEE8w32r5DUrpGMJlcfDLbxaSYgUmDIf+/f
 gXTPYUeBT8jMRxenVxMvB9LRZkdLoW4stB0AXRCwhJfi9p6zinNemMczFhdxGC2oLaGahjEZzYv
 FETQA++Uq32yS+yE56mvwtrGEocTsUXue3KtcOAZmbObFB/pSs64ZHEW4gDVwwmJ/Ot/DEmvh51
 /JtNs=
X-Gm-Gg: AYBFou3d+OE3sl5OL0tL3aWFSaI6q2gxOBAVUZYQTexLHGam7+HbmFRU3PDekF4ybEb
 rPNRPyHZAfdw1aOItz+fv5WBcYXLltjrap+83xb0s+DSqpESk5MzFRUcHDcQ9gYh5idrQPXnUvS
 HUj6pDNDbIZWZb8tzBZzVMjxmdNcQBxuDWgqWwIE1c4zWGFfwo7N+LQSe3gJJlbOkYugNaHJk//
 azuAvlS4I4+3aoEhnOvw4iO9+DW39N66+kojv0kTO4AbeSHwqugtVe7eU+1y9eBR52fSZlbMzaE
 fKOw7ZHEgKS4vc30H4/R62kyElfP5vjfm1S/MInaM0aVhiQ6BgwVioIgGy7UFgg9NcMK+h/mv8D
 C+JUfzzrsqPU5WoIMDKi9bvCgqLQb5DWpfe03WaoGcJIgzD2XdiazhePP5r8FX0nOCtWTgvK83Q
 G4AA32dIx/T2cKyV65D63piCzGyTQ=
X-Received: by 2002:a05:7301:4b0b:b0:35f:8c5d:5927 with SMTP id
 5a478bee46e88-361a16607c1mr15474543eec.14.1792514855734; 
 Tue, 20 Oct 2026 09:47:35 -0700 (PDT)
X-Received: by 2002:a05:7301:4b0b:b0:35f:8c5d:5927 with SMTP id
 5a478bee46e88-361a16607c1mr15474498eec.14.1792514854984; 
 Tue, 20 Oct 2026 09:47:34 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36632d8b273sm6318507eec.15.2026.10.20.09.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:47:34 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:16:26 +0530
Subject: [PATCH v2 7/8] test: dm: reboot-mode: test trigger dispatch and
 mode enumeration
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-reset-edl-rebootmode-v2-7-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514792; l=6704;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=yJ6hNAwfjOkacf8UVDHY2UnbvV4j52a8Z3C8EQhqH2E=;
 b=IVKDYcNBGgP30zLgAjOBW5vNs1IpLRpM06omeyw3ioXiXJwblxXI8VAfmVkLBcNmjNZEWp+7h
 EBEisyQDJ3kD3Nvznz2QaCbW29GBOvivIbCWO1yzMgK0aqC9j0R1+LL
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: pcIa7Oy3WXp08Hq1xuYucUnsacWHvwZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX3fXS4w4AQQM9
 Yo2uyXUgZBNeSqQ9gY3QwmoCZOxG+6Ad5rF9xXArxtiEK10w3xwETKqXOnLKUJGjHfQZpw/hKQM
 gcbM8mX+wnBc7Da9CBLFO4X9U6Pnkx7gZQfiPJQmUSZcMlepzm6BJECLIoqktORfCfGEyW5L7Ll
 YYyHTBT5aeqjk8JOv9cB3ZatGo6O3pj94Gshoe+SJ69NHmfYX7/TmVAE53UWg22R1ZBjXHUrkn4
 KsA3YhCvAQCiP7jRW+1+TK1EUX+u7kWMepWlD2X5Wq1YYj5nUeN+c1o5tyBdjlD0I9P1ugoA+qb
 LAwbHvgk71Xuu8E9H5BcFOdaD9UOBkifuf3ehmf+OEMGuMyCpzsmLbJVz/LnWSi+AbRcyrvPoAC
 ikqFdG5MAv7Xy7/VF0+gs3pxjpfYWTWn1+4Yr9ZcB5as10EB1H/OASg3HDHZiqrx3YwlZN52gW+
 kB3cFCGGx9hiaEo/mdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX2WU2JvTEW3Dc
 TWNxMsDhjTK2DgCFq7h03gYEqT8xCTbZ0D8KGFmMOVdr0+/EQLjhyOiZQppdbh9l5fMyxOuOZnw
 vUH+xEobQnyVsxpfQLIwHScbYu3cbLk=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad79b29 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=tQuXbDe6OOUVvikV3qwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: pcIa7Oy3WXp08Hq1xuYucUnsacWHvwZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200066
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

Add a trigger-only reboot-mode backend and two device tree modes to the
sandbox test tree, then cover the new trigger path:

  - reboot_mode_request() fires the owning device's trigger op with the
    correct magic cells for both a 2-cell and a 1-cell mode;
  - an unknown mode, and a backing-store-only mode (gpio/rtc), both return
    -ENOENT because they are not triggerable;
  - "reset -l" lists only the triggerable modes and hides the
    backing-store modes;
  - "reset -m <mode>" reaches the trigger op, and an unknown mode fails
    without calling it.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Test "reset -l" and "reset -m" through the command, as the mode
  listing moved out of the uclass
- Clear the whole magic array between runs
- Explain why the trigger op returns -EINPROGRESS and why the mode
  listing order is stable
- Use uint for the trigger() count and sort the includes
---
 arch/sandbox/dts/test.dts |   6 +++
 test/dm/reboot-mode.c     | 129 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25c99ef8147..c70c0eccc4b 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -214,6 +214,12 @@
 		mode-download = <0x51939147>;
 	};
 
+	reboot-mode-trigger {
+		compatible = "reboot-mode-test-trigger";
+		mode-obelisk = <0x80000000 0x00000001>;
+		mode-sarcophagus = <0x80000000>;
+	};
+
 	audio: audio-codec {
 		compatible = "sandbox,audio-codec";
 		#sound-dai-cells = <1>;
diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
index 9a3b2bf0a43..b91d4fc3377 100644
--- a/test/dm/reboot-mode.c
+++ b/test/dm/reboot-mode.c
@@ -3,8 +3,9 @@
  * (C) 2018 Theobroma Systems Design und Consulting GmbH
  */
 
+#include <command.h>
+#include <console.h>
 #include <dm.h>
-#include <reboot-mode/reboot-mode.h>
 #include <env.h>
 #include <log.h>
 #include <asm/gpio.h>
@@ -15,6 +16,47 @@
 #include <test/ut.h>
 #include <rtc.h>
 #include <linux/byteorder/generic.h>
+#include <reboot-mode/reboot-mode.h>
+
+/*
+ * A trigger-only reboot-mode backend used to prove framework-driven dispatch
+ * and enumeration without touching hardware. Instead of resetting, its
+ * trigger() records the decoded magic cells so the test can inspect them.
+ */
+static u32 test_trigger_magic[REBOOT_MODE_MAX_MAGIC];
+static int test_trigger_count;
+
+static int test_trigger(struct udevice *dev, const u32 *magic, uint count)
+{
+	uint i;
+
+	test_trigger_count = count;
+	for (i = 0; i < count && i < REBOOT_MODE_MAX_MAGIC; i++)
+		test_trigger_magic[i] = magic[i];
+
+	/*
+	 * A real backend does not return on success, so any return value is a
+	 * failure. Return a distinctive error so the test can tell that the
+	 * trigger op was reached.
+	 */
+	return -EINPROGRESS;
+}
+
+static const struct reboot_mode_ops test_trigger_ops = {
+	.trigger = test_trigger,
+};
+
+static const struct udevice_id test_trigger_ids[] = {
+	{ .compatible = "reboot-mode-test-trigger" },
+	{ }
+};
+
+U_BOOT_DRIVER(reboot_mode_test_trigger) = {
+	.name = "reboot_mode_test_trigger",
+	.id = UCLASS_REBOOT_MODE,
+	.of_match = test_trigger_ids,
+	.ops = &test_trigger_ops,
+};
 
 static int dm_test_reboot_mode_gpio(struct unit_test_state *uts)
 {
@@ -66,3 +108,88 @@ static int dm_test_reboot_mode_rtc(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_reboot_mode_rtc,
 	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
+
+/* reboot_mode_request() triggers a named mode with the right magic cells */
+static int dm_test_reboot_mode_request(struct unit_test_state *uts)
+{
+	test_trigger_count = 0;
+	memset(test_trigger_magic, '\0', sizeof(test_trigger_magic));
+
+	/*
+	 * "obelisk" is a 2-cell mode <0x80000000 0x00000001>. The trigger
+	 * backend records the cells instead of resetting and returns
+	 * -EINPROGRESS.
+	 */
+	ut_asserteq(-EINPROGRESS, reboot_mode_request("obelisk"));
+	ut_asserteq(2, test_trigger_count);
+	ut_asserteq(0x80000000, test_trigger_magic[0]);
+	ut_asserteq(0x00000001, test_trigger_magic[1]);
+
+	/* "sarcophagus" is a 1-cell mode <0x80000000> */
+	test_trigger_count = 0;
+	ut_asserteq(-EINPROGRESS, reboot_mode_request("sarcophagus"));
+	ut_asserteq(1, test_trigger_count);
+	ut_asserteq(0x80000000, test_trigger_magic[0]);
+
+	/* An unknown mode, and a backing-store-only mode, are not triggerable */
+	ut_asserteq(-ENOENT, reboot_mode_request("nonesuch"));
+	ut_asserteq(-ENOENT, reboot_mode_request("download"));
+
+	return 0;
+}
+DM_TEST(dm_test_reboot_mode_request,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
+
+/* "reset -l" lists only triggerable modes */
+static int dm_test_reboot_mode_list(struct unit_test_state *uts)
+{
+	ut_assertok(console_record_reset_enable());
+
+	ut_assertok(run_command("reset -l", 0));
+
+	/*
+	 * Modes are listed in device tree order: devices are probed in the
+	 * order of their nodes and properties are read in the order they are
+	 * written in the .dts file.
+	 */
+	ut_assert_nextline("Available reset modes:");
+	ut_assert_nextline("  obelisk");
+	ut_assert_nextline("  sarcophagus");
+	/* Backing-store modes (test/download) have no trigger and are hidden */
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_reboot_mode_list,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE | UTF_CONSOLE);
+
+/* "reset -m" reaches the trigger op, and rejects an unknown mode */
+static int dm_test_reboot_mode_cmd(struct unit_test_state *uts)
+{
+	ut_assertok(console_record_reset_enable());
+
+	/* The test backend returns instead of resetting, so the command fails */
+	test_trigger_count = 0;
+	ut_asserteq(1, run_command("reset -m obelisk", 0));
+	ut_asserteq(2, test_trigger_count);
+	ut_assert_nextline("resetting into \"obelisk\" mode ...");
+	ut_assert_nextline("Failed to reset into \"obelisk\" mode");
+	ut_assert_console_end();
+
+	/* An unknown mode never reaches the trigger op */
+	test_trigger_count = 0;
+	ut_asserteq(1, run_command("reset -m nonesuch", 0));
+	ut_asserteq(0, test_trigger_count);
+	ut_assert_nextline("Unknown reset mode \"nonesuch\"");
+	ut_assert_nextline("Available reset modes:");
+	ut_assert_nextline("  obelisk");
+	ut_assert_nextline("  sarcophagus");
+	ut_assert_console_end();
+
+	/* A missing mode name is a usage error */
+	ut_asserteq(1, run_command("reset -m", 0));
+
+	return 0;
+}
+DM_TEST(dm_test_reboot_mode_cmd,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE | UTF_CONSOLE);

-- 
2.34.1

