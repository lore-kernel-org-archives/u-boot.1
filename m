Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F99606D542
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SLTdFHtp;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cPcBiS5R;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sh3E23Th
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2F98408DE;
	Tue, 20 Oct 2026 16:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WReAF8GMjzQU; Tue, 20 Oct 2026 16:46:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F2DBD408CC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792514813;
	b=Bzv7UWakfsc9kTcQQs7jf4irhH5nkIe6kvksiWqq9zypPZ02UB/1M81G/E6kPnSOzLFm
	 hwT7iLKrsGhBxDW16b+5dYKoqeLnj03XbSa82EekviyKgSNlhhb5C0BqrNJvyT1BgN7wb
	 dAQCJJp2ejjdltBp8c0FFbzmp11Hn4oKAhE9E8J3UCwIlAAo1OT/hruW0nLXwGSXKZfnl
	 csHQntvh0j2f676jnYQQn7w3JO1sCm6AoEO1KZE/B1OWXpLgVo3HGea3/BbWrcqigNX+K
	 gTd6hOTNnu2N3yNsmNjDEXBkxpR1hwXM/80TJASfqbj5a2tg7GmUIWKSonNTASHioIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792514813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zFYHl+PwWH7wfztwLYr2hyDpgYq3lmIeiqCNrkYCXoM=;
	b=SB8EXfmJVN3Om4rijjbpMnsePuClOKLo66nXZtLWqkNxmC9GfDA/7+ruPyKXKhVfKMlS
	 Xfo+5Ne8nmm6sXYPacOFjnt5KYCIc+xRdCVZ35ZfsQ6rg+WoxnskkfbCGohZKVjB1n588
	 McAe7FzPwaNbJK28wLULYprJKi8roRaqMiLcT+CiFwlilsWI8xkOj+RYJhJt/7z1CN1Ww
	 og40JuKbjcc51tIUVJivkz331IevHa6Hln/n4P53ERlI7Sbov0P4EuMo/dVLjwiAYSGeV
	 yfW4xu7hw1pt5ynQCswt3EuVzqJfAwQLP0Vz31ZnqUraQ6iw9kMh0Y05GclsYAAbMsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792514813;
	bh=zFYHl+PwWH7wfztwLYr2hyDpgYq3lmIeiqCNrkYCXoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SLTdFHtp+EUGiiub7jWrg+SbTGjT5Ko0FCzHb/4PpBXbkWL8dmr20JKNeQJlB0xuM
	 uA4yZUvXhmmY74hVejU35mamuzCOZTQ/oy5MY5WttBIYM0ShRriZI9RQz+Rab9GKgG
	 9spEkVI63c4l0oJX0sqaeahp9jX5F3CZ/7gj3N8iBsQ4ZJIziEu2hAB4YFT2XiXQZV
	 ez684dwU6KZR1m1kuFIwqg+/W005q2FZl4egetxxhd2HoSINiRcI01lYAk/lQXfOUM
	 xC4aARUH7MjCSiRmb8r+XlrJF/G3DM8mrvwH/wWU1hNv17+OQohCLu9riAXVcdB0Hw
	 caWZC3CXD4cQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2DBD408CC;
	Tue, 20 Oct 2026 16:46:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55E6B769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 436C1810EE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GM3SprIij5U for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:46:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 820CB810E4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514810;
 b=k8XEEllO98vIz2yZP3VVBHKWbzgraBddULQbmHm1hTlfLUZa5nnDB/ibMQ0Uo4RZ8FP/
 O+wZkicDBrUqFgJkD7y/TrpfKTE7decXbP7PbWKr+mD+LkGY3THfNmNliKv8oGInKeamC
 ywnmxfs4372nmfpIBPajMl7rSVunBvcCC5DzvyWM99/9a8fo1FS/OrEj2IYMf4OcgNIJv
 1QNpX7uMaobaAC0JDaJr1QFJRnQlDF+EQzb0sCvKlb1a6it8SpVlfmHtpDxbhd6qEXS0I
 c3P1sr9PTp61yVFdMUTyT3xQCnujXCCKdqKxwLS4tSdqUYvF4ytBRZZFJmlbpmvuZkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514810;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=zFYHl+PwWH7wfztwLYr2hyDpgYq3lmIeiqCNrkYCXoM=;
 b=rlnv8U1NIk+V7iAWN2BMh58nXzICX9l9mQF6CzmncoAbP5HRWpwIu9dS6CIuPprUZGNY
 +9Upq6nODvJAwmENpb10bUBzcSMyRpNdeaSCYsi6ij8QkLw2IglKc0axgT2XEsLBCIqyO
 7s7oD9+tEpe5XHdC8rBfkiYIW/CrDTg3Mon+tx94ggZ3OD5cD9d0LKOdMoYl5k/WbY2r5
 sxaOpzoet4OukVbMuDjJyoOnMZr980f/ZsRK4dOsIrLQiNgu4hHdZiRyA3Hb1jqCc644+
 HQpZ+hUj7arEkQtgvBl0BR9quzo2SwlR1ayzG6q6xMG5VWyT4GIKjdsxPxa5uPJwCKA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cPcBiS5R; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Sh3E23Th; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cPcBiS5R; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Sh3E23Th
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 820CB810E4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDA1hL1209355
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zFYHl+PwWH7wfztwLYr2hyDpgYq3lmIeiqCNrkYCXoM=; b=cPcBiS5RLqziXgqp
 OY/pakM2yn7Gc1AB9kjBOpDy24wYFcMY4OoXXkzvxocWJ+nENLAWNxjg3yiSY7gY
 yHa+zfjprbQgUZKCiMRxP/WFqBpqp4K6sgQV0Xbqx7W8Qt/DFEo//HatENlqffHw
 xuwEG0vRBZB9aX9bs4IGOyxznnUqAHDw1dkb1agFCRltEFo5CysmrGnsL16Yk2qv
 Jq/e38QwDwc+QvrWcbj8F5FDeltqJoBuyDb2hMIh0ftsZtWUc4EJ2rsb057r2iQi
 wor/o5oZN6zfIrZLTrgvhnB5gg9D1SR+KgC+9jTy53PoMtUZQL4hx/ENaZaLK9s4
 2dTPBA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pbg1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36696c9f55bso573053eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792514808; x=1793119608;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFYHl+PwWH7wfztwLYr2hyDpgYq3lmIeiqCNrkYCXoM=;
 b=Sh3E23ThysYIpnvG/pz/BgHdenRTONJwjogHCx/z+1CkvIOp+3QhoTtApPCUhttfeA
 txESEeQt5XXT/PqXFMyjF25JjOFBs9jEfrlh5NTprRx3gZoMpVsJJfMeay1JkLSH/Kwb
 o44JXFInHPIr3fPJc4JQthe+SGj4SS+q77jbl2JEv2fWSsjNkGJxFdFUBxQkF6fEFO4f
 9rYh+Nf7oq/cTli+j90TuieldR7GvI3JqozoClVkkojcS/N2N7zeZr49GhKXfxJpcoz4
 MvATwHbrbdcV3zvLmwPMyTyxNi1aqpF+JOdyMtNPl0UBQN9PnAAZwJJwKln2CxxKfbF/
 KryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514808; x=1793119608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zFYHl+PwWH7wfztwLYr2hyDpgYq3lmIeiqCNrkYCXoM=;
 b=qfbqyhVn50TAJRKXMxndpTE8Lz8oUh/IYnsKJbK1Hp+eP8WrntLx/r/WnCLTEFOzeC
 FqwHBsQenCVzL4A6C8zb+io2Gw5wuqCvI05aMNDbovFBHEtyvl/J/j9kkki1yZwS41Ct
 oCfIGYq/VtTqZomi4ks+4bbsf/L0MquTRs2jJbEXXHnLPDZ9rg16qQn2SZ/o0E1Vucon
 wNb6z8QiM/LLhN5GXGU04CuK6uYH81XyshCOfWPixIkCjXIVOvMxENgalTrI0eA3O2p4
 nlljybUBPsIUuAMZzdOJvseQ6JsTJK4RSmwD9xWt+CltD6zs4o5WblyA4HE9wE+DG4PF
 g1Bg==
X-Gm-Message-State: AFq9FYIR5GWvZC9TqD+mabCeJvxHC3+0T1dezZvf2npDtgRQe+GuXa0s
 BPvRnoe01brrfR1zizkY7G0ZFBRSlzg1NvSUoBx4xLlxiTw68TPuIgVrRPrDdENHEr4a46NJcDL
 96HApiGTMbrkE+bbiwhC8vLJTucnXQ1qDwp5YUZTYxL/dp/xwY758aIRyQfkfohkuMSILC80=
X-Gm-Gg: AYBFou3TM32qfwB9inJFxccTXMwnJWCkIsWXIGeIiTi8maI/ocKRAzWL7LoTWC+47FR
 VVtfvCcoEl3LLk/0o8Zpc0Q1kJnCCodIaEjgu0Nja8NWQOt3GnE5C9K9ihWp+crEIBRuEF6beH7
 uiRjyef3vYqsx2zOlbhLcFqnE1xiVeeixps2tRumz5FeHUPBGKCxyWlsZcLdoTEj+i/5f9RlfPE
 bZDL/rjI4/VqHRLG/797pyiPdV2t1cVNbL4Rc1yCjq5Ar3D8dNpOph95iKji14KWVEv/g4RlLqS
 fSjcjvoCopZQ8eSNaCKsQ0u4fNt6nawj3GQn5jRovzi/II7+SN/AZxu/94BejVhkCJLsGgtD5DC
 s9dlVhozTQm8BHl2IpYG97Sw7qub8GIXA9gJagUUB8Kd/pCnQu/9hAWYd3jHMoYiZUnZaSwnpfM
 85D5j2aY5pPtl+Q8C3iNX+Env/TRQ=
X-Received: by 2002:a05:7301:4381:b0:34c:6edc:f4d with SMTP id
 5a478bee46e88-365f8290f02mr3486310eec.1.1792514808281; 
 Tue, 20 Oct 2026 09:46:48 -0700 (PDT)
X-Received: by 2002:a05:7301:4381:b0:34c:6edc:f4d with SMTP id
 5a478bee46e88-365f8290f02mr3486269eec.1.1792514807621; 
 Tue, 20 Oct 2026 09:46:47 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36632d8b273sm6318507eec.15.2026.10.20.09.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:46:47 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:16:20 +0530
Subject: [PATCH v2 1/8] reboot-mode: parse up to 3 magic cells per mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-reset-edl-rebootmode-v2-1-f690da515804@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514792; l=3899;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=L/OB39vY2FWXCUnUg8mPtASRjQTy3jjSh5+LzwF0h5c=;
 b=ySkhsA5BWaFJyGJPkGd4xnkn2Zz5HvCVVyfvYiZdgwJ6Axr9IQy/3pv4QVJD7o68K4CSaOQMc
 7uETMQS2pGnCobpL4C7W665x4SMbkF2ETWgZ5XcZaezP2ka7P6QwpUF
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: xsvnsF35nLwXpw3sM3hPBIZKX8EWZZif
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad79af9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=GESHroN6_YRezIVDoYEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX8nBWB1SdMenp
 GZ8NLNnynOTkVy7xkoGXGQy/bvYTJx54D3fkhGhUv43n5VtvYI9uQua8XJj04uO0s7MLFG8dk9w
 yL/fo9lkIs7KdrntqERgkL/aEi9q6B5UuOQ3bhv0jVeMJ+We9tATCRU1e/vsaTITZhLICRgQeZb
 qfA9vhRXiPyqRLe4y2rorGrB24/F9vg+jIPTxsZ8w0QLes/lmhnsXD5Rws35ywJknV+d2FrUfbS
 IGcm1cQen6puIg9bPveG2FEp5z/cpT5CGwm9xNoKdJ5tIoNh6mM6LWBvmso3TGVAvMqJTph9JIv
 xxVsNdAW3gQi8PmHKhjymjErIycn3dvDqxNeE3HP3473VVwIZzhl2TtCaNm/hmtOZ+lBqswmIaw
 /i8DDGiOVgiTxnPeh3FCT3dB6OPCzv/jj9bwovLDGK8eW4jJpkrYbpINHZN9VWCboHXP1nUgDVr
 AaATqHiLHjFjb3aSPOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX9rJ7eCYfWtnW
 VggyZTk/aJ6NXFL1eLuHHbyxR5vk1Iwra8nuYCeYdYungK9K5rl0/CXFnQugq8j4KpCxbdylWtS
 ufGqrpLa+LnIzqRs4KeB3xUWyMTSjQY=
X-Proofpoint-ORIG-GUID: xsvnsF35nLwXpw3sM3hPBIZKX8EWZZif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200066
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

The reboot-mode framework currently stores a single u32 magic value per
mode and parses exactly one cell from each "mode-*" device tree property.
That is sufficient for the existing backing-store users (nvmem, gpio,
rtc), but a PSCI SYSTEM_RESET2 vendor reset is described by up to three
32-bit cells: <reset_type[, cookie_hi[, cookie_lo]]>, matching the
reboot-mode binding for the psci "reboot-mode" subnode.

Restructure struct reboot_mode_mode to hold an array of up to
REBOOT_MODE_MAX_MAGIC (3) cells plus a cell count, and make
dm_reboot_mode_pre_probe() length-aware so it reads 1 to 3 cells from
each property. dm_reboot_mode_update() now matches the backing-store
value against magic[0].

Existing single-cell modes (e.g. nvmem "mode-bootloader = <0x02>") parse
to magic[0] = 0x02, count = 1 and keep matching exactly as before, so
there is no functional change for current users.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/reboot-mode/reboot-mode-uclass.c | 28 ++++++++++++++++++++++------
 include/reboot-mode/reboot-mode.h        |  8 +++++++-
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 7cbe02eb4ed..80aabf54750 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -30,7 +30,7 @@ int dm_reboot_mode_update(struct udevice *dev)
 		dev_get_uclass_plat(dev);
 
 	for (i = 0; i < plat_data->count; i++) {
-		if (plat_data->modes[i].mode_id == rebootmode) {
+		if (plat_data->modes[i].magic[0] == rebootmode) {
 			ret = env_set(plat_data->env_variable,
 				      plat_data->modes[i].mode_name);
 			if (ret) {
@@ -68,6 +68,7 @@ int dm_reboot_mode_pre_probe(struct udevice *dev)
 	struct ofprop property;
 	const u32 *propvalue;
 	const char *propname;
+	int len, cells, i;
 
 	plat_data->env_variable = dev_read_string(dev, "u-boot,env-variable");
 	if (!plat_data->env_variable)
@@ -93,19 +94,34 @@ int dm_reboot_mode_pre_probe(struct udevice *dev)
 	struct reboot_mode_mode *next = plat_data->modes;
 
 	dev_for_each_property(property, dev) {
-		propvalue = dev_read_prop_by_prop(&property, &propname, NULL);
+		propvalue = dev_read_prop_by_prop(&property, &propname, &len);
 		if (!propvalue) {
 			dev_err(dev, "Could not get the value for property %s\n",
 				propname);
 			return -EINVAL;
 		}
 
-		if (!strncmp(propname, mode_prefix, mode_prefix_len)) {
-			next->mode_name = &propname[mode_prefix_len];
-			next->mode_id = fdt32_to_cpu(*propvalue);
+		if (strncmp(propname, mode_prefix, mode_prefix_len))
+			continue;
 
-			next++;
+		/*
+		 * A mode may carry 1 to REBOOT_MODE_MAX_MAGIC 32-bit cells.
+		 * Cells beyond the maximum are ignored.
+		 */
+		cells = len / sizeof(u32);
+		if (cells < 1) {
+			dev_err(dev, "Mode %s has no magic value\n", propname);
+			return -EINVAL;
 		}
+		if (cells > REBOOT_MODE_MAX_MAGIC)
+			cells = REBOOT_MODE_MAX_MAGIC;
+
+		next->mode_name = &propname[mode_prefix_len];
+		next->count = cells;
+		for (i = 0; i < cells; i++)
+			next->magic[i] = fdt32_to_cpu(propvalue[i]);
+
+		next++;
 	}
 #else
 	if (!plat_data->env_variable)
diff --git a/include/reboot-mode/reboot-mode.h b/include/reboot-mode/reboot-mode.h
index 5fbd7c801af..54a8c09650e 100644
--- a/include/reboot-mode/reboot-mode.h
+++ b/include/reboot-mode/reboot-mode.h
@@ -9,9 +9,15 @@
 #include <asm/types.h>
 #include <dm/device.h>
 
+/*
+ * Maximum number of 32-bit magic cells a reboot mode may carry.
+ */
+#define REBOOT_MODE_MAX_MAGIC	3
+
 struct reboot_mode_mode {
 	const char *mode_name;
-	u32 mode_id;
+	u32 magic[REBOOT_MODE_MAX_MAGIC];
+	u8 count;
 };
 
 struct reboot_mode_uclass_platdata {

-- 
2.34.1

