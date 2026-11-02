Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21995606D81C
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ggijZcmg;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ou3EBYI0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jwcd8HON
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3D91403F1;
	Mon,  2 Nov 2026 22:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QmZMH_yR9HDa; Mon,  2 Nov 2026 22:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F03D4403F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793657294;
	b=CujTlaiCDIfjI+4r3SrQSuVux5abx41xJGsdE+lghQeAPmHtiV9NW2xQyimSK7dIVUWO
	 JRKP72pBwtdkYnrk2+MvacH64lfNiRXNXF0LWNOVBWnraf4CefY7KwDSAwW2jbbsqjthZ
	 8JpJMeloO40Nmao62L4FjU4tKcYbe8MMrY2GrDv61/EMJayMSyp4o4GzvrHnt6uS3Heyp
	 gKiXamMumidnq3AA7jeXjAH2U52JVzIN4UYl4AVykxfA3q3TV3a968XZ3uDkEPI3sZ7wW
	 JZraK+BBQdK92suLPcwVcbhB84pyYBx1rVrLsiop/kq9FdVmF/xS1zl1b1SnSo00BBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793657294;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gsl98dYJcGbdjwmluP5ugV3xQD7qENib1kU8PspQR4k=;
	b=deyY0U7jq0Alo+ZeJrSAsk7Dh7uBNA6cBtggSAxutR7AAN2iohHldlL1CcTDeclQvcqP
	 0HrqWfwvzA1BBifD0wKgsnec8dsYzXoaXTgPGGKyz68ukz/c40j0AfHQp4yJrBDIUPqpW
	 Qt4FUPvqAUvVleIAzvGpJis8gIwwtfaG/GLGxziWq/FPPS5Lr/8eVblFk+j/annJi6ii1
	 /6EDXtkm0LAC7SEt/IDPy5a0Lm+jPD9Qsu0tWaMJE89uR7XguuEut9ESxJTvvfvIwC+pi
	 orlB49uDdqTgMoC54imgxyz/QKBzgHzXEjevqlXiLMiIFCsti4aFenVTZDd9DfSwe2w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793657294;
	bh=gsl98dYJcGbdjwmluP5ugV3xQD7qENib1kU8PspQR4k=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ggijZcmgUcKKWjpKzyfRFWZ8X5Fxoqyc7agIDNuvUixy1patROShqMnZcqfsBDPOs
	 Rd1ItZtJ5jsRwULzdGmnXorVef3Oi5b7TfykY0jeVIIScQ2E6jmpiiHcQdQLLPhluc
	 YHeQXlARcyJvyZZZ1BVZRn3zuIP/gGbSNmHRezDMo7Sdh9PpP/jHdor7kRdgOtnQUo
	 f7F3KQ8QiRXMdIGecRmeHzLwWv8HoGc8mGalgIrGSgQs+0Wjoe8mhJMll7uVfpC+4w
	 TKdHDsjnMIk5NlQblNRxUFcwv67l4rkdUZouIJwfR1KLBBTnrb+YXsRM7x1IuoWQkG
	 mBuk5IHXsCfdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F03D4403F6;
	Mon,  2 Nov 2026 22:08:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 89A9AA15
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E29D605D6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 03tJ5gC2Wqyl for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 22:08:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF908605C9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793657291;
 b=T4ROUa2m9KKn8TptbWGTxC/puD4gytB0rfEOVO2XYM8Hfbcf8F+JzrPVEcNkqdTcGmCm
 HR/yXcxWVfUCc7z3ShkZCuEZRXtAVFKl9s9d+Zgw8gSeNcKJ5iX7iFDMU5ue5Nz3z48Jf
 bzbE4JHCTckfTGAVsFlDinkJvFtF+b/8sXDTCv9mhCQ0yYJEgC3ic+zkAQNp04quPMjnA
 Si2BABIKxDDKPzRuOyu29RJeYcUf0FE4EUCtR9hnjMZeuDzr7EiB5baGM85X32Km0h6p6
 Z+gstxXBr9Ool6/+BUzkZyqPN2Gu9uOw1qEAVy60M6TCkEglfEeBrlvOd8FfUjktlGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793657291;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=gsl98dYJcGbdjwmluP5ugV3xQD7qENib1kU8PspQR4k=;
 b=UAlc6YUuMz23xAZ6nDGN2Plx0v5jRzyU03Fr57GsxRNXmmEri3WQbyI5IKG3ThIhy4p8
 MGuz+z8QvPjF8iD4EoL0DJeyqgizXeEauvUxYEynhYAMbHZB8JVReXp4Dqr2y56EjtU7o
 GlwAIzebqYXw3eCSIitnItwg3YaqRZ3bHDaDwkBqr/IkV0Bx+3Wno/ofwqv5zWHBksfBp
 evUXoUEdvL90AvZJE5BjFgaRb933542FdHHBeNRRXBQrMUsRqPbBFAFwJKrKMHDkxuvIy
 qBWEj7w42o0q2uZFuZLwuBt9K+AAPvS6TJb9Y4HaGbxIJd1T07E0hoSUppAwx8ceylg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ou3EBYI0; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Jwcd8HON; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ou3EBYI0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Jwcd8HON
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF908605C9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:08:09 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K64Zv688361
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 22:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=gsl98dYJcGbdjwmluP5ugV
 3xQD7qENib1kU8PspQR4k=; b=ou3EBYI0K3fJVHFPduYmGVcH5UO5X8XgF6VNMF
 +d1hThZ9baBbk6ZPilp+bt3BTlKe+ZlFI/UKxKMGkGsOgU7Ug0HJv/5QJ5cSpcmY
 rpXlmrYnpUsfuk0qIhv42wqsyu2PbpomZahYo2LeJydLrR7G5Jphz2beWEk6y+pz
 wJcZ/LrjgCpdzzQXr9nnaIaNdaUezuA5SudsXWSzCNhTJyTmkXnzJtBpNOGEYhOH
 S/O7mMvhiup8BLXxEitDpLWlpKRbpJlvlYcNTOmuw+QDxeNBXnBfsrqJXxNjNLpl
 tBZiIQ79D03J9b0RPNhM+EDwfVjGC9uKO+L3VL8yck670UqA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfebdxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 22:08:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-943e8ff02d0so310552085a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657288; x=1794262088;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gsl98dYJcGbdjwmluP5ugV3xQD7qENib1kU8PspQR4k=;
 b=Jwcd8HONCOmNceVJukR9ISeMP4y50U4OPEXl5/WxLI7j+YO0QFrCGQODvW2frTDMKH
 oEnpRM7hrfx/Mep/907rGn9oTm44SCYv5gENCnrxhZQ/aLorsepktKR9LeCk3ntKLe9T
 SpjDfAlgxK4KlgrVfW9KDd9sgN1KizklAbfFGtNuCEZ2tP0TssRlf9kmjmT49x3x8Qa8
 n6hoc9Sbhb5OMfJE/8qZTm+jkzfPmRx7dLZ92hCUY2OVfM0YuZtumgt7MD+qKFLWocRj
 WAL+HcKsoaLemuyJKORT2Kc7kLqJz5A4MyiiTDaONEE7E/zkO7ZAy0ZeWJgiUzJ+I5Jg
 db4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657288; x=1794262088;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gsl98dYJcGbdjwmluP5ugV3xQD7qENib1kU8PspQR4k=;
 b=uJfBkWeIPp924nmFEPbgEPEnnepDnaquhlj0JHiVItX4a2Od2lrrSdpKbhWA8lXvaj
 VhdibLqrDmxwkUopHClNfux4BfoDBzWfQW4GsuxnnfK6/JXP4INHD9kn/sjm1ktSI+Z8
 EkIUwGBR+g8bMssg2u1+F/angE1RiZPIykAYCJf3J9qF83Tb2Es3ZZu22dxMGaajUsKw
 veMwatvsRni0omYTrs4dF/lVh0PgdtEqY44THjI6WhSOyL4jzVk79Yfav9rm4e/B6hsI
 Bf/RjnZi64ZaDq/woyJk8xgDP/UgGx8i8WSaYP/aPvQrZqNIR/ogJ9Iew7NOK5bRPABI
 h+sQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXez6IGe4FfGYjY8TClPmFocedRksSEIOVKlDMwlKVJPt6/0l0vlBeCZa7gcaiPB+7LaWg8Fc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIM4fzkk/KWRoyfZwWBBss/tJeD0duOEgKM5BI5X7GTAVByHvqW
 DUVNWqAH+uHGuFl7t0eOfgHdlUw/u/n0e8kDVCfk+bfdk14gtJ1bVmnI9hf7oMfzt17W4U918SY
 kFCDM71+epbvDm/Hzrpt3Hhnwsy3c/nA4RWfiXs0kQnyTxhU2ncNb+Mox+4ciW0mGTmXzQbI=
X-Gm-Gg: AYBFou1HRQMUDyGxZAmTRXSvVoDFd1HPh6io2xZvvarqmvos4z3PwSyPLHRvX2Yk0vQ
 iEzuhAzjcAFb8VBwn+RjnY5zW/qzQpeusIezq0aF+02HhQpJ8lW2rZL6AHF1vCt1fUl503H0AGW
 HsfkgB8Vz4AxQov5VsSNp+JDZU465nWjyKAP3PHJcxh0VXMEwHAXKCNAa1vl3SsTmCwfpmGpEHV
 z2BECGe+ytzQX6Tl/bmNQhmZtDyCp3voc68geoz+ZoZfJeTliXCpkmTOtdBF0J0Q/3Fokeexk3W
 WWFRr6RkqGIBXautVuEjqZdpsi9XjTDrHsyDDiPk4UT3U5kauAFddEfuCa0poLYvItCLP6QT20I
 hl/6EDruWtgzBN5vZozkV6Nf8BGK1ER7WpsdE6wQnBicgX2HlsVIPzdm+5XVhcbvpUHIcH9v24S
 ZBRszg3fAUio2X
X-Received: by 2002:a05:620a:28c6:b0:93c:6fd4:467a with SMTP id
 af79cd13be357-94421541a87mr1833952485a.2.1793657288198; 
 Mon, 02 Nov 2026 14:08:08 -0800 (PST)
X-Received: by 2002:a05:620a:28c6:b0:93c:6fd4:467a with SMTP id
 af79cd13be357-94421541a87mr1833947485a.2.1793657287667; 
 Mon, 02 Nov 2026 14:08:07 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cec1441fbsm26877166b.64.2026.11.02.14.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:08:06 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 23:08:00 +0100
Subject: [PATCH v2] cmd: fastboot: default the buffer address to
 $fastboot_addr_r
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-fastboot-addr-r-v2-1-65ee21f29fec@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQrCMBBEf6Xs2S3dQGPx5H9ID2uzsQHbaLYWp
 eTfjb17GXgD82YDlRRE4VRtkGQNGuJcwBwqGEaeb4LBFQbTGEvUGPSsyzXGBdm5hAlN58UKt5Z
 aD2X1SOLDezde+sJj0CWmz36w0q/971oJCY/iiQ0PnXd0jqr188X3IU5TXQL6nPMXKmN4XLUAA
 AA=
X-Change-ID: 20261102-fastboot-addr-r-28fe6ea5615f
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot-qcom@groups.io,
 E Shattow <e@freeshell.de>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae909c9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ay3RODGZSXWSrlBDHH4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX12EwZPN9WisM
 DlDysFyqApqIgX45BBwM+r+iYiCGcxUXyamOc+deRl5tHxQjWlwRvX19huJlPhbgR4YcASNNNF5
 wh9lH77cJ952hkCF1f2gbF4uiN0BGAOmZtUqUwvpepy1q8g03yuEGSWtsjO4Astat9pTH2ehv7I
 AydDca8Hn4qLZrWzAiCj3xcNe45b932DZXGxHzabOiDV4bNHHDXlXxoekDjrlGdkIiSs/vzloKt
 LviNT0n1bnbQktOzDz/AQbKmX1fWmzQaqw5+rARSvuWAdkl4yx8RJ9pFOcxLktFIT0hsQ9CcAlZ
 y3iuHr7++wr24vJ3DuR+bmGZNpwFx+6eNysLBXrWe3YE4aFNVzezYohR5OmfzPsIvsvQoEJL8ME
 WnUSiqXZ55JG1zniofc3HjQ0rmurjS+nMMJ0lzDoBD9j1BMZ92JSSSXgeSz3uiYFEw4ZqUNL8xb
 zRL8vjm5LwxujkHw17Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX3pMio77mE6C/
 MjYI6GG5xTSd5ljXoge9CXZ9z51OtMipjZ9NszQckWQYdPbU22XReabKfDUtzvUkfO8ynNzs0hY
 aoTC5/tBvn93UEy2b1u+fHcG3xf1yM0=
X-Proofpoint-ORIG-GUID: ONA7zbtClB9AUXPSWMUmijB8xe54xRJo
X-Proofpoint-GUID: ONA7zbtClB9AUXPSWMUmijB8xe54xRJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087
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

The fastboot command downloads to CONFIG_FASTBOOT_BUF_ADDR unless -l is
given. Platforms that only know a usable address at run time leave that
at 0 and put the address in the fastboot_addr_r environment variable:
mach-snapdragon allocates the buffer from free memory, and so does the
Samsung exynos-mobile board. Their environments wrap the command in
"fastboot -l $fastboot_addr_r usb 0", but a plain "fastboot usb 0"
still downloads to address 0.

Use fastboot_addr_r when it is set. -l still overrides it, and boards
without the variable keep using CONFIG_FASTBOOT_BUF_ADDR.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Tested on a Qualcomm QCM2290 board with qcom_defconfig: before, the
first "fastboot stage" after a plain "fastboot usb 0" crashed U-Boot.
With the patch a 100 MiB download lands at $fastboot_addr_r (CRC32 of
the buffer matches the file), and "fastboot -l ${ramdisk_addr_r} usb 0"
still places it at the given address.

Refusing to start with a zero address instead was not an option:
sandbox uses address 0 as its buffer.
---
Changes in v2:
- Leave the command help text as it was: it describes what the user
  can pass, not how the default is chosen (E Shattow)
- Reword the fastboot_addr_r paragraph in doc/android/fastboot.rst
  (E Shattow)
- Link to v1: https://lore.kernel.org/r/20261102-fastboot-addr-r-v1-1-7ef1a2ac8fd1@oss.qualcomm.com
---
 cmd/fastboot.c           | 4 +++-
 doc/android/fastboot.rst | 8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index ace877b6e28..795c3138cbb 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -7,6 +7,7 @@
  * Rob Herring <robh@kernel.org>
  */
 #include <command.h>
+#include <env.h>
 #include <fastboot.h>
 #include <net.h>
 #include <vsprintf.h>
@@ -88,7 +89,8 @@ static int do_fastboot_usb(int argc, char *const argv[],
 static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
 {
-	uintptr_t buf_addr = (uintptr_t)NULL;
+	/* Boards which place the buffer at run time put it in fastboot_addr_r */
+	uintptr_t buf_addr = env_get_hex("fastboot_addr_r", 0);
 	size_t buf_size = 0;
 
 	if (argc < 2)
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 8e15f287f9b..ba817e8c1eb 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -68,9 +68,11 @@ General configuration
 The fastboot protocol requires a large memory buffer for
 downloads. This buffer should be as large as possible for a
 platform. The location of the buffer and size are set with
-``CONFIG_FASTBOOT_BUF_ADDR`` and ``CONFIG_FASTBOOT_BUF_SIZE``. These
-may be overridden on the fastboot command line using ``-l`` and
-``-s``.
+``CONFIG_FASTBOOT_BUF_ADDR`` and ``CONFIG_FASTBOOT_BUF_SIZE``. If the
+``fastboot_addr_r`` environment variable is set, its value is used as
+the buffer address instead of ``CONFIG_FASTBOOT_BUF_ADDR``, which lets
+a platform choose the address at run time. The address and size may be
+overridden on the fastboot command line using ``-l`` and ``-s``.
 
 Fastboot in SPL
 ^^^^^^^^^^^^^^^

---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
change-id: 20261102-fastboot-addr-r-28fe6ea5615f

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

