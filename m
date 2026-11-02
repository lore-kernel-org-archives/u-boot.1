Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B0606A327
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qi0NdWQ3;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aDTSxB6j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aiadft5h
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EAA8605E9;
	Mon,  2 Nov 2026 22:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dVisVfGqlo4q; Mon,  2 Nov 2026 22:21:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 40C65605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658106;
	b=OWDCdEqyDyqLQT+sHhA5Gr6/q1q1XFdKeoxGKC+En6Q8AdnSgq1f/eSBli1VTtyaQQQb
	 XoRiLYH1hLafzPbO9LKe6PciSmZXRh7p16tZ3MozWfs47r3hY9l15L2ldvy9QcpL2cqBb
	 2PAnWaLZt32SDCIzNxnJsWzWxocVkPaeRJZb2/YPUUP0/y+X4t/cRnbSFFp7JpPwT5+Tn
	 xH8vkTEQ60IbG/MgLGc3KzPXVaajJBQWUsY1eE5owDff3I91UJzA//mInLT7BBPQ5ehbe
	 7xMk0NR7086q2/dI8Tjfr1RX2/Gagme1IzGodDJqZj6f5QgOQ3TrxhHtyDLvOzMXjuA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5cl0kGG3F9gaqp3fSBEy/qMbwNAC69NEn0azfCXBhmc=;
	b=V0HoCnel5ex8JHimUGtcTTcwVuFxBOXN81I/jfhP41U4w0X8VhHFn90b0I36MuuLPN7o
	 ThcUrwerKqNhvrUC68LPBHGdeXuBAfxVWfABVtI2AFKa42VoOnMGo3Xa1NeDcYFVA/J2Z
	 Yo+aOqa4LO5jABRL3Oh7Vv+sCmhAgu38fGN9k2t7HmJiG5uZiNZhXbvGKNLCC5M5URBjO
	 DXJ4ELw6LqTwZChMK1rQ9SIsTCNaKvyQD6jBk7MGxJedyMAEpzD3DlU3SMGqd/KD7+M1G
	 7Myb9vF7anxpkTnxvTWiHcOtytObyOCFnw412dtQtdX5W7VvKVQADUAJpYa23WykOVQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793658106;
	bh=5cl0kGG3F9gaqp3fSBEy/qMbwNAC69NEn0azfCXBhmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qi0NdWQ3eEjNuSVENuQS1uPcNRJCmHAIsrjra3O072k391O5hvPZA4yJITEOpSEJX
	 AvlNQ5uD53iNMszGri8ngS1MGJXLrv2eKpiv8UcTB0evzdoqkeVu2zvFWva6TjYlWO
	 CQ7j1RFIauVa7aZwyOuJJIFrFsxsXuhHfByt35sKd7sDA2PvQ1LOG7twa44SSveGp6
	 QPd5hIkOJj8J/jPB7HIyXfTVS7I1tRPl8hXJt01jgjHtjLXLmKIq3WOu2qeHPH+nV0
	 KTZolAS4dcr4DLqioIIn/sLv6dI9wyraGsHReJdn7fAwiA0GVvWIdHxuNLBVgfqMZU
	 bG7xCbfsI8jPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40C65605E8;
	Mon,  2 Nov 2026 22:21:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 222E94BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 138D680C6E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoEDs0bt7ekb for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 22:21:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17BB180BE0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658104;
 b=lSIrp1cbWz+XV8GC7Lfi6BgABM1VFqTDVLT/cLSNAOXKP0yprO69D3iYTGFhIF2tQGFD
 RR2FIg52ywA93XJL3kKW1eiDc2mJfH3kLj2AS2g1Dc6ICyYrakjnmHm97yESEq4njoPMs
 0dZx6uD+3+3jGpdhIvqTPlKrBsPFn6hK2oIkwChus7J+Dj8d1xmAoCqEKvZcvskB7l+Eo
 s+owcn0EsiiGjKXQCZU3Jm2jqFsrg+ttLWrtP/0C6PK4QOxOzyk4blQ9m4yM2s1P8fBa7
 FLsc6kx+7aXCqEWNgGQXAsMz/D26UAixTz2ihZgX0M2L1qaHmKWtAMX4rwGATSs4Gbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793658104;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=5cl0kGG3F9gaqp3fSBEy/qMbwNAC69NEn0azfCXBhmc=;
 b=rCqJGNODUMDB9f2EnSwRiq//XKsz6htaIyE/5WXhWLDg3bpuliEwgrD/DjM1XZ6aZKPi
 FTfSIP/J4gKWnRY2vripyUFnPlYB6zRkJP6Q6RyaynT7889cTRrB2k6WuveC09NqrQpkR
 bpfmp0swI3dCLmUUVVR1ZeNDyZ61z4t/Nv+dX9N1HVmzwBrWg7SVZ6v136iJHIlALXEMQ
 Cuzya7Vxfp0hkKtWutGxx79ueUUGa4eMqH7oh2FaLCQMcxsyMFoOmqH5RnWPG3dfciGLg
 Lneks7L6rMVpUNCJWDoMfqAchhNWZU0xfTO3kYbfteFgssnPxdSZ12vz5UVV5uS4uCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=aDTSxB6j; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aiadft5h; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=aDTSxB6j; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aiadft5h
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17BB180BE0
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:21:43 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2LHerx878272
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 22:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5cl0kGG3F9gaqp3fSBEy/qMbwNAC69NEn0azfCXBhmc=; b=aDTSxB6j8dMlgECa
 cahsuAofatKjxxl2Kc2eW4YB35RTyCF3cXLTe2EEM2hbFUb2qKB2XdZw2sAf3dtW
 uip+7yO3GTSyAG03Fxo9DwGPCa2gWvcbmp8t+5x/MK4tF9cWSjMjV2q9POn+65mu
 SqYpn5zM6w8hi/sq4Yae8MrwG+pXKktAscUztu1GzaHKbiPqkMinE6Tw2BRh8Bqs
 Nq3BA5sO7zQgqhT/bcdcEYxfuLEo1PUJjgCFqJiW8r2vm8dh2ZnUNp1ihz/0c9UR
 /+l6IVGFHn6iHnNwIQ3aUzK0jXITpOe8zBV5+dnVOpdvwIdNls04E8O9M239Yecb
 3nI6Pg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2acg6a7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 22:21:42 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b16b1b7aa5so55849017b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 14:21:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793658102; cv=none;
 d=google.com; s=arc-20260327;
 b=Pv10A6Ktm0JRT+R1tm9rhi6s54iGZICXigI2FxRAULMdvdTql+cR/B5TsBoYAMRjGk
 ceVuefQuOzjIxgKMPzQwQDmHe9onc2wZ7DSR/b0+fFiiJq9Cntl4bU8yq0o4mArrkIzD
 iFe0jUuag/sQueSXvfEW9tRUUzFGt8FwwPYrpegDioNwwpIZx7tzRc6PV/RSkANVEHIK
 oVbtiKLzee3LIRKo4PU7aIdq60+jFDM2IU8tk+fC85WLoZ3Bhu1Hoy0Y0st9YFTtZ7fR
 p2GsBBwqG/u7kkqEQfNwKxQtFkNLJgG1HXjnP8PhUFjuS6tZ2mtuz2PxGVFrraNB5svh
 jrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5cl0kGG3F9gaqp3fSBEy/qMbwNAC69NEn0azfCXBhmc=;
 fh=i9/SgGtsL1YneY+55J2+fNQ/znD8XWYmIK8YAy42Jj4=;
 b=pPsynwHeJThcaD4tRJq2rUJsnQj0BOry2CQdQ/OEb355b2VUPQGJp87VwIbvUq6v0z
 o7ShrLxMTwcVaz0jw+i91eKViO/Nd6KebZYm7Rp+R1qKOpxuoxYQfqmT63mYKUDOq3RE
 +eRRNzhQ6n+8sp59f1jgDlQVrebDrrWXDEaVKgiVjU4U/vSbq/p6jmxc3UNWYHjeiWKc
 aHCjyD4vSszJLbV37l5UlhmYkvarz8bjm2Y/uUU/6U0kwOsnDz7hmRO6tgscqL0J1Xus
 2oGpfJXrQ4WQhCEjQ4Arfzwyox60LWCxjZHQVBU7hyWlwgEepemcuv4mmPe2h69xcgZQ
 atIQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793658102; x=1794262902;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5cl0kGG3F9gaqp3fSBEy/qMbwNAC69NEn0azfCXBhmc=;
 b=aiadft5hnb4PkhAfWV6jOQsP7fziQ4fE9/k28ED7gKEyD6f7Ww4FOBKlsk+CXxmHKL
 rTDKe8vTU6Kv3xb+gbPiI+ClGbj4Jp4m/DKbDA22U33d7i+qt+2rY4LJqSgDaebd4YzT
 zD+WV3TtlyxveMy1mFPVf2ap2eyOmb5zICwbIhxKFYlmnF9uc67JHzOXRQQiMAVtjOZ9
 xs2hdIIDv1Aou6uxqe7Cvj+8yCYXvNDnwICIJJ0+0pXclAe5XXiPz1eDFxU+H0a4KjBr
 1vGbT61nZ1MRqup6AzNqTzDalyLgK0zl/cvZBNWC38hPB2RAEL1QAbMq+j3ocGIRgkWu
 ZBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793658102; x=1794262902;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cl0kGG3F9gaqp3fSBEy/qMbwNAC69NEn0azfCXBhmc=;
 b=i8FzLqywZdQDZ0/1AGinyenoYCEQwyDOCMzadFuwcLROi/sSnydyX1ekPAao19f72S
 4NkbfOW0kBKoWuZDO99ckTeWaLPiRgV0qPSkzEjnpr3nabDVWHK93c0d8kBD0+uAriJ1
 jqLKbo5PDcmDRB6H5qWE3wZnJTWAzVLahc1UO8pgYYPXbevfVsGLnB1fEbMnviBMiS7Q
 w2/1HDoRA3WcjFRnH6d+JMMSha5MKVnbSMDij39SwY2eangKl80hYwfYeR1FS2PLCMdV
 77LQeY8HesDdFPshC8YybOrpF72AMCPgLEH9SYmVcmKzwPDwR511Q3Oc/3mCMJweOTk+
 F9KQ==
X-Gm-Message-State: APuU4Z935uHWGTqFmqR9jUjSrvtTtWKecPrdJyKdnw9tmeAeba6286Se
 Biehgc4Re+FpzrEj3HUmStH8+1IVkyYEMbc+FVqGAmXkf1DseppZYLFVz+KBukWL83xuyUGeHOn
 5l/Mwd10EvUjF0kfiVi99HoM8ldJkT16M+pAB21PCcnYC3UeXSRh7KuNyIUNjQD7CZZmSMS7vE3
 +7sqGgCEbV8+Ung9zS9aV3tlRinMARTRREo20+f2FzHMTeLQ==
X-Gm-Gg: AYBFou3aPsdyvELU6vg4zrugsR4LKbRERFw7ViMBY95+OBALPTYTRILNouvk+QKqhaI
 L6vjhRoX0znMWtWvPLOHFU8VBkrzhfItNeQTV6ZCtVoAmHa5mPvGST+ZZ9f5yr3cRIn3Uh720hj
 RyCZ3Xk4x/AFqTuBI/vBYJs0dBF3Qo1TPnbNTBqoHTico/ZlxaTMk1HJI=
X-Received: by 2002:a05:690c:6989:b0:8b0:ecb2:884b with SMTP id
 00721157ae682-8b2b6707c48mr89103097b3.26.1793658101712; 
 Mon, 02 Nov 2026 14:21:41 -0800 (PST)
X-Received: by 2002:a05:690c:6989:b0:8b0:ecb2:884b with SMTP id
 00721157ae682-8b2b6707c48mr89102927b3.26.1793658101176; Mon, 02 Nov 2026
 14:21:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
 <20261029-upstream-optee_rpmb_b4-v4-1-e2e4c5330d37@oss.qualcomm.com>
 <CAC_iWjJDzJVM_5MfXhbmGEPpqQLXRV+Nbt=zSn2mxkGkz33ARQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJDzJVM_5MfXhbmGEPpqQLXRV+Nbt=zSn2mxkGkz33ARQ@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 23:21:30 +0100
X-Gm-Features: AclHuK_y0BQNCIlCvHmGwSnHOYzIeymi3x0s_6jiKo1Hphry-_srf_Fwn4aRMFk
Message-ID: <CAPzfCAYOfN1N4afCEFnG59gtbHWqqaoDtfassiuC_zUQZMd42g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] optee: rpmb: select the RPMB partition per request
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae90cf6 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=co3nPYg2vu35TmA-7YAA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4OCBTYWx0ZWRfX/2prLE2TDNs1
 LE9+yfZnDsbTAFBE4qYRgWYgnqlMT4sJHgV0KRS8hzY1A/geQidK266RLZX2lv2K8XAHRwtYAmy
 HgiDBEW4ZnFzbUyTJX8DAEkZYB2j8+bxowrxpbjbml7xZu6BwV74+3kYmiTYDg/YPTM76YZRo7u
 jBFTZaeEhmAu5kokDaCxjhHNdCJk4jsW3XKzuBcEY643ODA8/JbSYjP0+z0L8KnUc/19jra+Ur4
 4q+3gb1iHADi/7NZ4o62dYDdEcGoxgWFoIbE2poUoa0Akl2uxNFDvudWlR4Rj7q+f7gwRxQFxVP
 LMMTJWRvi4m0U5wqO5nsrdSL8gIPKDRPlW1Td5IR/dcLzpl1atvQSQvc8ozNRJ3lpaMqIppGQw9
 aujI/ugPxrEbuxTFs5WbKgvoWljn2+qKAylWaWfr61nbzxwTUF4U0o4O49HwM7h1PX0XcBqYLfh
 QXR1rRmN4OFg6IksCyA==
X-Proofpoint-GUID: BSz2EAGvE9N6RH1tVC9-EOtoxhj3Rsse
X-Proofpoint-ORIG-GUID: BSz2EAGvE9N6RH1tVC9-EOtoxhj3Rsse
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4OCBTYWx0ZWRfX6Q4V4B30oz4u
 PtZIJh61/ynGh/Mx4Rjfhc4YVJmAtNlH8cE65w/zV0WPXdEGfc3Jj1sjuGUl/m29skim/m+RwID
 oizeQdVffKHqKdyN/yU1GQoEauz1vXM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020088
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Sun, Nov 1, 2026 at 12:18=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Igor,
>
> On Thu, 29 Oct 2026 at 17:45, Igor Opaniuk
> <igor.opaniuk@oss.qualcomm.com> wrote:
> >
> > The supplicant switched the eMMC to the RPMB hardware partition when th=
e
> > device was first used and only switched back when the OP-TEE session wa=
s
> > released.
> >  Between two RPMB requests other users of the same device switch
> > it back to the user area: libavb does so for every partition read while
> > verifying a chain, and the Android bootmeth reads boot/vendor_boot righ=
t
> > after verification.
>
> I am not sure I understand the bug here.  do_call_with_arg() calls
> optee_suppl_rpmb_release() everytime we return from optee which calls
> release_mmc(). Jan introduced a nested call on that that would explain
> the bug?

You're right, and the commit message is wrong. The partition is
restored every time a call into OP-TEE returns, not when the session is
released. And tbh I re-tested  both bootmeth with AVB TA (+ also with
RPMB wiped) and
separate avb cmds like:  avb read_rb, read_part, verify, write_rb and mmc r=
ead,
without this patch, with only patch 2 on top of master, on QEMU with the AV=
B TA
and all of it works.

I can no longer reproduce the timeouts and I/O errors
from the commit message. Seems that they came from a tree with several fixe=
s in
flight at once, the sdhci status-timeout one among them (which was
accepted recently),
and I wrongly attributed them this patch, so I apologize for the noise.

So please feel free to drop this patch. Patch 2 applies to master on
its own, and I
can resend it alone as v5 if you prefer and you don't have objections.

Thanks
>
> >
> > With RPMB left selected those reads hit the RPMB partition, and the nex=
t
> > RPMB frames were routed to whatever partition the other user left
> > selected, which ends in status timeouts and I/O errors (seen with
> > the AVB TA on QEMU's emulated eMMC).
> >
> > Select the RPMB partition around every data request and restore the
> > previously selected partition afterwards.
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > ---
> >  drivers/tee/optee/rpmb_emmc.c | 88 +++++++++++++++++++++++++----------=
--------
> >  1 file changed, 52 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/tee/optee/rpmb_emmc.c b/drivers/tee/optee/rpmb_emm=
c.c
> > index 7ae6045511b..d4abc48f764 100644
> > --- a/drivers/tee/optee/rpmb_emmc.c
> > +++ b/drivers/tee/optee/rpmb_emmc.c
> > @@ -42,51 +42,55 @@ struct rpmb_dev_info {
> >
> >  static void release_mmc(struct optee_private *priv)
> >  {
> > -       int rc;
> > -
> >         if (!priv->rpmb_mmc)
> >                 return;
> >
> > -       rc =3D blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> > -                                     priv->rpmb_original_part);
> > -       if (rc)
> > -               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> > -                     __func__, rc);
> > -
> >         priv->rpmb_mmc =3D NULL;
> >  }
> >
> > +/*
> > + * The RPMB hardware partition is selected for the duration of a singl=
e
> > + * request only. Between two requests other users of the same eMMC, fo=
r
> > + * instance libavb reading the user area while verifying a chain of
> > + * partitions, switch the device back to the user area. Keeping RPMB
> > + * selected across requests would make those reads, and the following =
RPMB
> > + * frames, hit the wrong partition. get_mmc() therefore selects the RP=
MB
> > + * partition on every call, and restore_part() puts the previous one b=
ack
> > + * once the frames have been routed.
> > + */
> >  static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
> >  {
> >         struct mmc *mmc;
> >         int rc;
> >
> > -       if (priv->rpmb_mmc && priv->rpmb_dev_id =3D=3D dev_id)
> > -               return priv->rpmb_mmc;
> > +       if (!priv->rpmb_mmc || priv->rpmb_dev_id !=3D dev_id) {
> > +               release_mmc(priv);
> >
> > -       release_mmc(priv);
> > +               mmc =3D find_mmc_device(dev_id);
> > +               if (!mmc) {
> > +                       debug("Cannot find RPMB device\n");
> > +                       return NULL;
> > +               }
> > +               if (mmc_init(mmc)) {
> > +                       log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d ini=
t failed\n",
> > +                           __func__, dev_id);
> > +                       return NULL;
> > +               }
> > +               if (!(mmc->version & MMC_VERSION_MMC)) {
> > +                       debug("Device id %d is not an eMMC device\n", d=
ev_id);
> > +                       return NULL;
> > +               }
> > +               if (mmc->version < MMC_VERSION_4_41) {
> > +                       debug("Device id %d: RPMB not supported before =
version 4.41\n",
> > +                             dev_id);
> > +                       return NULL;
> > +               }
> >
> > -       mmc =3D find_mmc_device(dev_id);
> > -       if (!mmc) {
> > -               debug("Cannot find RPMB device\n");
> > -               return NULL;
> > -       }
> > -       if (mmc_init(mmc)) {
> > -               log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed=
\n", __func__, dev_id);
> > -               return NULL;
> > -       }
> > -       if (!(mmc->version & MMC_VERSION_MMC)) {
> > -               debug("Device id %d is not an eMMC device\n", dev_id);
> > -               return NULL;
> > -       }
> > -       if (mmc->version < MMC_VERSION_4_41) {
> > -               debug("Device id %d: RPMB not supported before version =
4.41\n",
> > -                     dev_id);
> > -               return NULL;
> > +               priv->rpmb_mmc =3D mmc;
> > +               priv->rpmb_dev_id =3D dev_id;
> >         }
> >
> > -       priv->rpmb_original_part =3D mmc_get_blk_desc(mmc)->hwpart;
> > -
> > +       priv->rpmb_original_part =3D mmc_get_blk_desc(priv->rpmb_mmc)->=
hwpart;
> >         rc =3D blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_RP=
MB);
> >         if (rc) {
> >                 debug("Device id %d: cannot select RPMB partition: %d\n=
",
> > @@ -94,9 +98,18 @@ static struct mmc *get_mmc(struct optee_private *pri=
v, int dev_id)
> >                 return NULL;
> >         }
> >
> > -       priv->rpmb_mmc =3D mmc;
> > -       priv->rpmb_dev_id =3D dev_id;
> > -       return mmc;
> > +       return priv->rpmb_mmc;
> > +}
> > +
> > +static void restore_part(struct optee_private *priv)
> > +{
> > +       int rc;
> > +
> > +       rc =3D blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> > +                                     priv->rpmb_original_part);
> > +       if (rc)
> > +               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> > +                     __func__, rc);
> >  }
> >
> >  static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
> > @@ -130,6 +143,7 @@ static u32 rpmb_process_request(struct optee_privat=
e *priv, void *req,
> >  {
> >         struct rpmb_req *sreq =3D req;
> >         struct mmc *mmc;
> > +       int rc;
> >
> >         if (req_size < sizeof(*sreq))
> >                 return TEE_ERROR_BAD_PARAMETERS;
> > @@ -139,9 +153,11 @@ static u32 rpmb_process_request(struct optee_priva=
te *priv, void *req,
> >                 mmc =3D get_mmc(priv, sreq->dev_id);
> >                 if (!mmc)
> >                         return TEE_ERROR_ITEM_NOT_FOUND;
> > -               if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> > -                                         req_size - sizeof(struct rpmb=
_req),
> > -                                         rsp, rsp_size))
> > +               rc =3D mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> > +                                          req_size - sizeof(struct rpm=
b_req),
> > +                                          rsp, rsp_size);
> > +               restore_part(priv);
> > +               if (rc)
> >                         return TEE_ERROR_BAD_PARAMETERS;
> >                 return TEE_SUCCESS;
> >
> >
> > --
> > 2.53.0
> >
