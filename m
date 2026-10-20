Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C5606A32A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IlGB5Ep2;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R0hZutzQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CFF1UwCa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB92680A5A;
	Tue, 20 Oct 2026 15:38:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UuFSbVBbeOep; Tue, 20 Oct 2026 15:38:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F6EC80982
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792510722;
	b=VcS044h6g7Igda3mYkvrBD/bGx46H63lO5ifiHTemhty3oygvVoLVAgbDCXNkN0s8Sv4
	 lcjNO6JOc+Dm9p2aDawx1R8IkaUL3jAmqOhdzhWEeVKYEdHuxmmDtMB7Eojfyd6KBxWOe
	 pGyqJIBmipYXkIO+HMDn8hCxmkF52lfMSzxVboFt2vsCQqwn99a6I6dvZF5gw6x9XGuA9
	 pWgvyxTVgyB1PUs9CMIPzYTjua0a1qGboXjCnMLxcSeDsES1eVx0vhQ6YeSaxP1v9AZFX
	 ZkGEtqlp0joM7+HgPEkzonZFHZTGh0pSdTWVjlP/9cvVr7Q66qzz3iv+5hsP+e0VhXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792510722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
	b=P+5xDse18kgBiff3zR8htHtodUBGrpQwJ7PlPCcHGnoHIka5kkT0A5X7swgeUx0ael8b
	 BBFOKrNDYFr+IxqeiNVsiub1wjqeR95pCEV9JJqsbLEMvamljlI5cELRTpIZnxtnHivtQ
	 4z9gFmU/WW51yEat8HxxUfMRYfgV34fHMofAWfBa2qVVfTSeeKN6XeUUto6/yT3NpCQpw
	 wLqrYV/l2XsQEMcLQ2uIdcmhmFc1ReauwvHM75Wse+mK/RxjmzEx9DBL7WyGoF7e772Kk
	 98OtIj/O+WqX9WtpMYB6bO2BXQu0nqDQtgKmL0JH1wQr83KO29gSVDi5CK5Nyg/rNQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792510722;
	bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IlGB5Ep2uaNFCJ7hzoLrrAxLN7MU6eUIGklEEdoLrlH6A46tvvwNtto4M6F+bNTLr
	 yEUSoVO1OOZHgEbuu1caFKcgHgxXB3yQWRfBIaAIwk7FzF6bihv3Te0A5YmMgj+M5m
	 vswzlXJc5m9sJu9xHECNQNgXaGsGEhwm3pzoGkw5UnMHpy2UFsDE7F1jXfA9dGfJhi
	 kf/3sQOnXcsGtGR6Ewq71A39No2bUIk0w8f9jpsbLc6GTk0PvQGNb78U1/zsm915LU
	 TERGOkTVh5r3TRBOE9eoIO8cw1RhaofnXuEJdU7HQNrtMKPfBoQvil6pPk0NHLCHkS
	 gZ4MUijS1ChJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F6EC80982;
	Tue, 20 Oct 2026 15:38:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9061F75
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8107360899
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JvycIY6DFDsv for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 15:38:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ADE8260807
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792510718;
 b=DZ86sUHyPVxNX/mwMXdCbe8unWV0DAGAYzYNBpyTtZyrP5rtTD8fmsPC22CcHr82EUFt
 K12bKlA1MGBi+3W4ZPu4G9+IxqDkDI0Bt0IUbxmQdgzUMqvywmvr73fNRoGiwIlnUcGbC
 MEAxqAvX2gUiSZE/iVn3ElQzsBD14L3XhatL7qDOOEUSVaDJM3cqXKyWw4JIQLHamvRXo
 pFqBdxfevi17fAVdxgaUU3DNMh+4V9NMhsA91uV1ZNu4vUXD+koLG59VGoa4D7nQeNWK1
 8octecY9V0NwNjiXHCdBK0zLQDSVGoEeHRQsgxYCjOht6ez2Ca7lCkl7CJlSwtw2slQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792510718;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
 b=EEIe7R+NZvgqqQn+3V2x8weYcwTt2PVqAvJpEHZV6CylIs6WQ6pL6rD+7kwdyMg8U7iU
 Ia6IfLO5/IMkub+t5JPo5UOzFF78+GjA+YMPHv0ASKyTABrYQHOc+PYXDbOp8cQ5pfzEA
 5y+3cyrZ7Ps+uyzprQBL4Xq2tMKvjGg/aZW6YonbXSabzDnOtLmfJdpuV1PY3psD6pbbe
 5ud4U7OtfnEUpp7i4t7XMZwyI3XCOYva8Tl3R2t5M7bFu2BPKHZtJIFlTIPBgoBVMUw5H
 1A98Wq46oGRx/8Ykn3/JYsfpJtksq0QO3hx5l6TWfsCp8YTiMdX6NuwrILrcx+DB3jA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=R0hZutzQ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CFF1UwCa; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=R0hZutzQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CFF1UwCa
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADE8260807
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:37 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KFL14i2020275
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=; b=R0hZutzQWUAn8uFH
 /d1m8omP0iBBBCucp1V6LC/3+taxtdqV121yShGq4OnGf6NHlNqOcMGenrYoZ11P
 rPf3Q5jt/UBCov1LqPz5wmWQt3gu1D+56C4AaPstbujn8f8WLabKwcNQCGX0E4FF
 cyHEMqt/RPhOMe7wQAGRSsn/ph2gCweAV5K14d2aPPQS5oWTxP0qhi3rx4eMo3+a
 mntlJbPRHs9+gI7+deiS3Ocyy76VzDAVWF32JKJg/Ps4PJDVC+y/sYwgg6Nsr27P
 TIPQMdRcFGLxG5YsvaulEzGYAak3/07EiVvIPV7wwYgBxljN0DrP6YJ8a/hjNbjD
 uajfAQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n3783-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:36 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91792488228so66381866d6.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792510716; x=1793115516;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
 b=CFF1UwCa3eliWxrctGhUqwnc/m2i8OZCVrDgTqTbGqSs+3pyqNwZiRdcmq0DD8bJHq
 ejJ6efQvbuiNZiKd8q+r3yfdn5l7z4l4DFj868HaSsj8Khdj8znSmpBR4k503bwRvSBB
 214fvy6SrLbifJvF/+RrJtPER0aE5whDUz3QGpF+0WGhRp6t63XZWvqkXl/IGyfxvMMs
 7j8IXOh/QksALXEVRf2568ZLR3O2mVlQyyp1XYMxH/2ujPX2opeJkauj2Bq85LdobCxz
 pmbmtA0LPGLmQsBaoh1OK9LchhTvdJFfBFwowqnCfFnETk1K7tlF9bOlNBWugIaep6+x
 QBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792510716; x=1793115516;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
 b=rhqJdXHMPYACFIGE1v9W8+x4B6YpH+cKrQjPXnPxmoZNsQzmqUSbroTE1PbFylfV5c
 3St/FEbZyx+/Fmjaewg2ImfHlQosDJ2LiV4n7mX8Ogq+oK4R6K6r2elXdx63nOGJZGRQ
 iPrGLUjQwvSm9KCvFmirq8CtAqmsndLQaN39ynuDmHYcvu8nus4r6OtYkUvncma9KU9b
 jVebHRRN2/pgFj7AAirORhYqGUgvOXv4TuDbMHoiktg0uVDuJTzxXm104L3KnVE/+hxz
 FD0ZkUfu5+jj/OoDsDYEtz/8OQgFkazqA9bWnWf05E0Z3Czzjousmp63RUdlj9Jd/pwv
 H0TQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByXnxKCzoJmZUbJ6cbyUsOEVp2US8mNlUbUGlbA+E1g5EOxJJf+jP6J1CNnlPTmlJHDRU26r9A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLF1g00OpNSTEzRhKY5gt6seMBy6u86YhubEOqUjuc27k6QLEuA
 JlLTYX7jS1Oj9DMW7oAT/OqdEvHUTTDdS8ly1C8tnpPD/8+mePyxP2xOdhfLHEmpnbDARW0ipcw
 oUNUnEm8Vn75UEtq8onFmAWyDHq16jaeUgHwEibkx44mSuSVoCML3gssexUCEd1R1I0anyKA=
X-Gm-Gg: AYBFou1bSn+3JwGWxjvRoyeG2juQQ7dRI7GeD+io7mtNPrcNBXuMO1ObfeAILdmfu2r
 38IrRQoUAEks9VzDnFAb9OuOsC7Zc3u1trusCb11t16mrOs9XTtPPfLGztGmrRqUxcdwWVfLu2M
 Q6a/MnVVOcnq8plKZlKL4iSJU2Ywloq/8q5I9K4P7O1D02oohoOOjy1bFERLP5mbwCwr7IDKkLw
 oZIr9xOjJo/X8kRMil+RLYLxDbzBP60ieCr9lciWV9fYVFwibiGUQa8mr2ZSXDKThdUEMqIeKMC
 yYfzkTUh0CGez5TMVjrKH+fsNz2/m1ra5ASR8ewa4ztiMzYS+peL8eEgrLePnqmUmTTKw4YXteI
 n/NBo17F9Ek9fRmggFab8ipisX1Yd4X19I9CXmEMRgTSp
X-Received: by 2002:a05:620a:c4e:b0:93b:ebd8:9147 with SMTP id
 af79cd13be357-93f29cf01a1mr1792154685a.18.1792510708683; 
 Tue, 20 Oct 2026 08:38:28 -0700 (PDT)
X-Received: by 2002:a05:620a:c4e:b0:93b:ebd8:9147 with SMTP id
 af79cd13be357-93f29cf01a1mr1792149385a.18.1792510708191; 
 Tue, 20 Oct 2026 08:38:28 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1b140fsm5574963a12.9.2026.10.20.08.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:38:26 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 17:38:08 +0200
Subject: [PATCH v3 1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-upstream-avb_lock_unlock_b4-v3-1-e280795a98cc@oss.qualcomm.com>
References: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
In-Reply-To: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: Cyxsiuo_PX8bgUpQUEPAX66emCDyOIOD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX9QJF7uB92uPs
 TiwaSdNFZXBMzAsdnBP4OTI6uYJdJ0dX1OTHQ39i2Zvb5SRVW3Ir3uuXo+CMuVbkxKq0ExuV3e3
 Y46j+/R6pjOOxPqEFCbjClW5iWcg3g4=
X-Proofpoint-ORIG-GUID: Cyxsiuo_PX8bgUpQUEPAX66emCDyOIOD
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad78afc cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=MoAT0fEG2T6-BM8MC5gA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfXxILkpZqIRuss
 inIG4loO+k6cF9/rOLRTeNnQlaGgkfrfnlXiQjRwuXUQ0dmMSJ6BCxkaHI0pyIW1fNr16ib52VP
 LQc6JNf6Jn3UQH/q7mGpogW19GNxe9x1Vzm39MERWqzI2sjiZUjrCiGZl9OiN2C0QCXsd8bnUCl
 VLJuw2nn9DdgP6HUF5FVKSiYrYdQK8ZaK0AgNRutXCQn7U0fiP/LHdjTcmOFu/syrzAJ1AnbvlU
 qMaySKGKoB17vZUR0AK9aVYyBBmkU2CY2OazA0l0SXf55N/9g9X8Oo04itSQR3IJHnO+MrGiEZ+
 F/jeX8ZlzBYolOedy1mTwepEWm/D6sxsfc9zxwEsIPxyxi3IZxPahUAetJYkZOalLbT6YqqbURE
 E/CawrEmYkZKbUw3ouL2mmyyVJYGacLCqGU+/Gb28tdoRvrmMpXy/8mWW6fpcq1Us4Z3zKV6sT3
 QeDE1XMvjOt2POVZvfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200062
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

write_pvalue stores its argument as a NUL-terminated string, which cannot
carry binary data such as the 32-byte SHA-256 root key digest consumed by
CONFIG_AVB_ROOT_KEY_TEE (persistent value avb.root_pub_digest). Add
hex-string variants to provision and dump raw persistent values from the
U-Boot shell.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/avb.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/cmd/avb.c b/cmd/avb.c
index 8a915b65834..3c13d6a2cb2 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -6,6 +6,7 @@
 #include <avb_verify.h>
 #include <command.h>
 #include <env.h>
+#include <hexdump.h>
 #include <image.h>
 #include <malloc.h>
 #include <mmc.h>
@@ -439,6 +440,100 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+int do_avb_read_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	const char *name;
+	size_t bytes;
+	size_t bytes_read;
+	size_t i;
+	u8 *buffer;
+	char *endp;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	bytes = dectoul(argv[2], &endp);
+	if (*endp && *endp != '\n')
+		return CMD_RET_USAGE;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	ret = avb_ops->read_persistent_value(avb_ops, name, bytes,
+					     buffer, &bytes_read);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Read %zu bytes, value = ", bytes_read);
+		for (i = 0; i < bytes_read; i++)
+			printf("%02x", buffer[i]);
+		printf("\n");
+		free(buffer);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to read persistent value, err = %d\n", ret);
+
+	free(buffer);
+
+	return CMD_RET_FAILURE;
+}
+
+int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	const char *name;
+	const char *hex;
+	size_t len, bytes;
+	u8 *buffer;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	hex = argv[2];
+	len = strlen(hex);
+	if (!len || len % 2) {
+		printf("Value must be an even number of hex digits\n");
+		return CMD_RET_USAGE;
+	}
+	bytes = len / 2;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	if (hex2bin(buffer, hex, bytes)) {
+		printf("Value is not a valid hex string\n");
+		free(buffer);
+		return CMD_RET_USAGE;
+	}
+
+	ret = avb_ops->write_persistent_value(avb_ops, name, bytes, buffer);
+	free(buffer);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Wrote %zu bytes\n", bytes);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to write persistent value `%s`, err = %d\n", name, ret);
+
+	return CMD_RET_FAILURE;
+}
+
 static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
@@ -452,6 +547,8 @@ static struct cmd_tbl cmd_avb[] = {
 #ifdef CONFIG_OPTEE_TA_AVB
 	U_BOOT_CMD_MKENT(read_pvalue, 3, 0, do_avb_read_pvalue, "", ""),
 	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
+	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
+	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
 #endif
 };
 
@@ -491,6 +588,10 @@ U_BOOT_CMD(
 #ifdef CONFIG_OPTEE_TA_AVB
 	"avb read_pvalue <name> <bytes> - read a persistent value <name>\n"
 	"avb write_pvalue <name> <value> - write a persistent value <name>\n"
+	"avb read_pvalue_hex <name> <bytes> - read a persistent value <name>\n"
+	"    and print it as hex\n"
+	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
+	"    string to persistent value <name>\n"
 #endif
 	"avb verify [slot_suffix] - run verification process using hash data\n"
 	"    from vbmeta structure\n"

-- 
2.53.0

