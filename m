Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C9606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R9a+wnBu;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eIbb153d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q4chHfCa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B50A380F7F;
	Thu, 29 Oct 2026 14:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8IDQkGBHTH0B; Thu, 29 Oct 2026 14:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 813CE80E50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793282845;
	b=C8QxrwfTslGg9CHjYOCyLWSytCqU4ffB5+hX3QzN4Iq5lTmFJWm0Vg5g4US3+YOxxbMR
	 zeUpw7Vyt91hfW4d2Y0iCqSCJtYbr6Chk8joC5oQtLQwtkjVDHoebRg2GEpaZ7n3r74cr
	 MMwDH2NlOb6tqwqwRjy8gYO3o56nehdD4TKFcbW+KBNbEy9mgjDkVxg3OYVufk68Bvcgf
	 hSc4en/h1MpWGnSqtlo9Nrm463Cy1h1YHEMPOdM8lR7bBI8P1NuXGcNJHhQnw3YdI5flX
	 Wh3JqIAPHU53Lhroyv76dbhZTFJSpAADiz051cp1Dd8yIoc1fydnhWW8uy8Z1Qvapbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793282845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R5/SWDX6l2XJ6ko0LWb1EruYnACxmr5VCR5VLsTb3tk=;
	b=eZ1L/nQ5dayf3DWu8BfSk8E922f5u1x2qxjgCT5Vj2ie22famuMQzWaWqoLza9yN56Ac
	 RznIZuh6fQBQD8St+NXY7D0dflOL7WJzBD8x/tv7sbeXkUwvt7DpNNPS3SIETgtPm44Hw
	 j1S0oz93ntvmH2sEM7+MPrMDJ5+megCz91zwnub1LNq7UQ9T5S4au7s1RIht4arf+YiwV
	 mt1bqINr5csjhPXaQawjdYtMMI6WHuyzqQM6xmy17GxS4ayyThQoK7BXQ9t+vGkg7MCG6
	 cXd1tYY3FixkobS8sZ7C9dCM1xV+MC3HDZ9CWiFXg0tHrfdpnDtgumQ31GtqQUocEIw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793282845;
	bh=R5/SWDX6l2XJ6ko0LWb1EruYnACxmr5VCR5VLsTb3tk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R9a+wnBu5NRmQCDFn3FZJ2eyXkfZkzju30hTQu9sz9/wk8R9uDuhe1U84/J++Eynw
	 qhP2pAUte1M4MorjEP8cf9seDDsFPiezNn1QpIDwymtx3BEtGiZfRlLjmJ0lnpyoJ3
	 YYTWmj3vb6XtQug/g5gYLeVZhNNuO5LadfXxD8eJ+6VUCDisW82Gcr6nc9oZKv20f0
	 sRadUy/0Ebe8m0i+c2guTleZpDHesoHVCtT4Zvj81osq55h7MlYCR8gPydowU2u72w
	 8ZPaA+cXtJzmjF31AclswiGipC8puSWMNVq3eLG+Dib3BRcAxBNriUL3EPhGb1cheT
	 Dc+AIlNqlCPhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 813CE80E50;
	Thu, 29 Oct 2026 14:07:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B1609380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 976CE40318
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IaFnAeRZ5IFF for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 14:07:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 58D3540024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793282842;
 b=GZDqf+/x0nOgET0kVFMId0oFQpxpHw/CzKu1pEPfVbAomjMhCJEaOHijyfhEjKfN5+/X
 yj++ebhVCNpDeQgQv7GdoT67GCerlXzAEx65zk7U04B45pIuAVUncjwAND9PalGJxHldo
 vAqVpSWvQ2Tqgzoo6GcxiNCZHQ+D4qCLDzJQgsr/XivqLVgUHlA+AJXvDd+hDRX94fZ9G
 smH7QXczIikbK5iB+GYnPs1VYKn7oX4mpuE49108Ubz9RlC10miCLMyIITd1F8V/0hL6F
 Yau4E2rA+BgZVfhLQ4mCv7erByN8frjlgJGhv8RVjoU53snDNqnReQLLuFHAMBMFo8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793282842;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=R5/SWDX6l2XJ6ko0LWb1EruYnACxmr5VCR5VLsTb3tk=;
 b=UI6bw02hByOhrgzTPtPlGWSty8y0fQKHn022jVciyqX36N4NqbbQqPiz7nf1dZqTiCJz
 ZSl6TwGYCvqtAJ63blMgffp3opei/VxQEEfeXD98NRxNe5tbYPOyOs/Vdxd1QsK5bJQfh
 FsDP5AK4WbPTmoZrbdmYVpXhNM4SkSFIUVx4OIIdA5igPo6YNHCp/HJYD/2Xekdc+2ee1
 i1Eg6Unf5hbC7TFKa8KxJR/XNiAgyJeXX/+aH46pHAgKStZSpL5iO6e1V1vtaD3zIsbLz
 BdEBrWwd4qY8KO1gzXwx8at6dtfZ+tqJdh9rQcNsDy+m4i1kAFKZiOM74/b2KAXnUDA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=eIbb153d; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q4chHfCa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=eIbb153d; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q4chHfCa
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58D3540024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:07:20 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TDaBTw3521348
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R5/SWDX6l2XJ6ko0LWb1EruYnACxmr5VCR5VLsTb3tk=; b=eIbb153dmQN2PjGo
 Y5XHIwNcEypdeNvXbqrRLt3aNMCGQS8gtLE3DPwDgmMLZKokHNE3PVj1k8vDjb6M
 Z1XCmCTBzw8glUeCNZ66zZ+uQAtweKgYawXfmfcTg9LLeD1Mvxv8UKs67Z8MJODP
 Odtx7wgTwBzbpTxKVcRTEtFdoJVnpQcKTODcEuGuUdvNoxT9AulDoswKzoHYZj2g
 h4WPFc58a6uXc9umVfkSKBUzNTetLFHdpvzgv4+M1HzgLqxoM/9qS4GYCsCEfot5
 i0jN8auIYyYd9MYXFNUy4uThoLQgl8w1B0R0E5Y3tpgc9SgH72UM2zi8t6+NT+lQ
 ABNagw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76204kf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:07:20 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b16286c152so34117207b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282839; cv=none;
 d=google.com; s=arc-20260327;
 b=YhLrNDuDrklR/sTMDxlK83ri8+YMvW5+jf2qmbg7LA9qq4rz7Tiw2IlE/XOZkNEc4d
 A3HU1vHf3SDmAj2qTmWuGOTOZmxf+NW0srNhwaWFb0FseXpQW0SiGlnFr8pe0EBWs0U2
 oSsLlQQIOTxmclQ8ZrmbA65UX0SUG1XphBbIZ+4kDlQGO3P7sTATM3szwJlhGUVF3LXP
 Lj9Oeg+d5lJrvhaCP0P0QGRByvDkTH1MNbhGVrwNdo8+BWOV7UZWNsVyOZ8wyTJJsDIz
 obG9qpQSshWo6NYTy48sJ9mBZewbCf1gk0tWzpKuKV5UnL/GU3B/X6KUZz+iOCl1Pp4L
 WC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R5/SWDX6l2XJ6ko0LWb1EruYnACxmr5VCR5VLsTb3tk=;
 fh=i9/SgGtsL1YneY+55J2+fNQ/znD8XWYmIK8YAy42Jj4=;
 b=r+S0PgNlGYlzdlG+tU3janvqLpqYSxH+dbWQBH+qBYsTF7TbB9Nfy9Jb8+FVg04RNh
 OPvIilwkvh9xj3t7c8IYXJnBOo7mJPEoSmx19DUgWdEuzD/t4JUraO08zYYHpmuWSckY
 8zaHP8PUttL4vhSMMQmMixhWGcRMEzc6ZdwxSRP0vBT7H1NpRtyxpbuz+C4KY2tfD4KU
 TC7EKE5tegijq3Ez2sDUY76KwAxQFNdEJlcNsh0WzJBoN3R42Adz391NBh6ZVgHDAa2K
 tGEdn2e9QjHEqfO10Wxge48vqNZS2hhfVuKPPUxepdlRaBhvCC2RfBDOofgfApbVejAr
 Xz6g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793282839; x=1793887639;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R5/SWDX6l2XJ6ko0LWb1EruYnACxmr5VCR5VLsTb3tk=;
 b=Q4chHfCarVlwkaZDc0uD8ycu95CVJL39UanpuSUEFEehDWfuET5PXjP/5Xc82NItF7
 BQ4dy/KP3EQJkvckWXoAHn+JNx5Dh9/ixSuDFLe1ya/0A1e8NPhtPqhlxtCf/j25N+c7
 44ujtlFaU+jaNijlwZPQNw5Nvv7GaJqM6KeEKBnDJtaMUivniR5hy/u9HS5OSOOVFKkh
 9iUAXSKNr1/vXmC/g54wwULGj5uN/SoXC8RQEh6ALUJxO2NRJuSUrDPItI3Axa6N0fwq
 ohCKbqTtdFB70PdoL3jDcz5mGLsBHd0p5xkTFkd0au4zm4Auhn3J9pgRH7+jGD3RD4Au
 3Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282839; x=1793887639;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R5/SWDX6l2XJ6ko0LWb1EruYnACxmr5VCR5VLsTb3tk=;
 b=OrvacGtDmLkAk1vKcUy9Ddl90MW2iM6fesHZ0jXpb+VI48PDmldAvq+2VzQQi3mewZ
 Bx8Y24K50cr52zTqaRCRtlgcEP4mstDPmfjCOipZskdZW0UZwuLpX33NmfHfLuHwLqED
 slbMAncOgfCshjr8jQHqstkGQBDecX08c/RS58axsjWoMIIT7Jkl6y73ed4xCF3avryj
 rn5uLzz+udU2KbsQsIrhVYr7DjeIEAoREPgKMUZtuJWaHcp48oQNQt0aCfyPnQnmr1tJ
 5xlz5jnpXslUP/anlxEdlw+U2HJYInEs1wBElnvB3czJ6Tyo4cTLlRB7CoFMgpX8VlmL
 oa3g==
X-Gm-Message-State: AFq9FYJCfZV/QWohZou3vOYIwX/W8S1teSXUgUIWlaxzTyScUDKse15M
 VaMKP5f9sXj2T06/TRda+juBgZ5Z3eunyiAPTfaFZwJ5/j9Jy6MN36WR/RqPRidUvytY0obvwJ4
 iUyEgvIuaSCEnUyyHjP0piEFS7n91lkzh/OnveaSUS0E+2BSJLFqT+SwevSZ070O+NMJELT+mHu
 9UidIuaqdn8UFSa2ycCx7yZSUP53vnwT1vgJhsKRqa4/0I1A==
X-Gm-Gg: AYBFou3b2I+TcR2Sy7nbF4hlN8SZUBkSknP8mJV+rp8JF3jCTFdHxujBXba7b4Se3Ql
 LgvmSioOkE5Cl94LWndxqWP7IY20EK6CWjwcyAIyRedqYgH85MnDHPVXnwMXEJmpt+Q4G9UCwe8
 Onc8kvpsw3uhfek1e/ig3n9ADV/tgtlLtYKYv0SkxCX7v7iDU/lqtOhCQ=
X-Received: by 2002:a05:690e:12c2:b0:675:d561:1eca with SMTP id
 956f58d0204a3-67a7bce570amr3689717d50.72.1793282839229; 
 Thu, 29 Oct 2026 07:07:19 -0700 (PDT)
X-Received: by 2002:a05:690e:12c2:b0:675:d561:1eca with SMTP id
 956f58d0204a3-67a7bce570amr3689528d50.72.1793282833412; Thu, 29 Oct 2026
 07:07:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
 <20261019-upstream-optee_rpmb_b4-v3-2-c97cf24fc56f@oss.qualcomm.com>
 <CAC_iWjL5V9q=4aJF-T_FXjTTevy6ix2L-PEfE8UcP8riR-duAQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL5V9q=4aJF-T_FXjTTevy6ix2L-PEfE8UcP8riR-duAQ@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 15:07:01 +0100
X-Gm-Features: AclHuK9woworWN-kIcAAyDlcj9N6FTtoR6i7wW7_ULAEQeXbnlej54YdcAS7mms
Message-ID: <CAPzfCAZzkoY5=1BQ6Shn1EDSF-zscT4jeNwT+v7spyD8X5PT4w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] optee: do not announce RPMB from within a
 supplicant RPC
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: FcvTc722-pYmwhFflqQo0h4EPy6rV9H1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1NSBTYWx0ZWRfX8owjJRJUAjap
 0/UnNn26L0tj0Oo+NSmiX585j+0/KcsrrvbkamxQTnWAEzHYMV8Q1X/sB44kQ1MMSRI5gg3D4np
 6lz/+MhVBElQn1x+XU3OR7ohERSJuX/XDIyPgZ3pZbKxC6aW+y/h54IHNHEHwP62JYOXWmEREW5
 KbMWpKO+br6F4/ny+3ofu7YizGw/1MeqVOPypSbOYShu/J5742Nt0RiBnOfNJQyyMLwdRSo1tgl
 VzDuHCf67zvmznBbu896IP3KUYCtx4YqvfselpBWOm6GaQ4GNQJQbRvziwvMsH4E7Xr+WlTO+IS
 3qUnlrJ70a96XSJJpKKyXvUrtIv3jhNzt5gIXuTdRVSpB4EYa4x/x9x6Jn0e3gG8FP0G+ku2Eoj
 mZmoDD6/wmQh3hmb1pEhZ1VslCwSpUljT0EycwFdtxChIcfw3I8hpoYteICOrR8BAveR1YHmHMO
 zrnSKJMJbEShIUgBR0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1NSBTYWx0ZWRfXzvrckD93JVIK
 O4urWlRLPBcMx1v7jsZhwe7hxesRMa0MIZv6j+H/EhuGH0Mab9lVNre9oATQS7CqSx7FHI57YzV
 aa934kGB9fTE/QUSemtdQdjDPPKMQSo=
X-Authority-Analysis: v=2.4 cv=Kv3YSmWN c=1 sm=1 tr=0 ts=6ae35318 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=M8XV02_b7QD1F6vQUy0A:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: FcvTc722-pYmwhFflqQo0h4EPy6rV9H1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290055
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Thu, Oct 29, 2026 at 2:36=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Igor,
>
> On Mon, 19 Oct 2026 at 15:10, Igor Opaniuk
> <igor.opaniuk@oss.qualcomm.com> wrote:
>
> [...]
>
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > ---
> >  drivers/tee/optee/core.c          |  7 +++++++
> >  drivers/tee/optee/optee_private.h |  2 ++
> >  drivers/tee/optee/rpmb.c          | 11 +++++++++++
> >  3 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index a47c76811cd..f7670096b61 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params,=
 uint num_params,
> >  static void handle_rpc(struct udevice *dev, struct rpc_param *param,
> >                        void *page_list)
> >  {
> > +       struct optee_private *priv =3D dev_get_priv(dev);
> >         struct tee_shm *shm;
> >
> >         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> > @@ -450,7 +451,13 @@ static void handle_rpc(struct udevice *dev, struct=
 rpc_param *param,
> >                 break;
> >         case OPTEE_SMC_RPC_FUNC_CMD:
> >                 shm =3D reg_pair_to_ptr(param->a1, param->a2);
> > +               /*
> > +                * Tracked here rather than in optee_suppl_cmd(), which=
 the
> > +                * sandbox TEE driver shares with its own private data.
> > +                */
> > +               priv->in_supplicant++;
> >                 optee_suppl_cmd(dev, shm, page_list);
> > +               priv->in_supplicant--;
> >                 break;
> >         default:
> >                 break;
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index daff3e04493..92e3b3bea10 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -42,6 +42,8 @@ struct optee_private {
> >         struct mmc *rpmb_mmc;
> >         int rpmb_dev_id;
> >         int rpmb_original_part;
> > +       /* Non-zero while a supplicant RPC from OP-TEE is being service=
d */
> > +       int in_supplicant;
> >  };
>
> I am not sure what was fixed since the last version.
The changelog is in the cover letter [1]. For this patch, v3 moves the
counter back into handle_rpc(), where v1 had it. v2 had moved it into
optee_suppl_cmd(), but the sandbox TEE driver calls that with its own
private data, so v2 wrote into sandbox_tee_state (the issue you've reported=
)

[1] https://lore.kernel.org/r/20261019-upstream-optee_rpmb_b4-v3-0-c97cf24f=
c56f@oss.qualcomm.com

> This is only defined on private data  for !sandbox right?
> Then it's used unconditionally in handle_rpc(). Won't that break builds?

The field is not conditional, struct optee_private always has it.
handle_rpc() is in core.c, which is only built with CONFIG_OPTEE, and
the sandbox TEE driver never calls it. The only other user is
optee_rpmb_available(), and it skips every TEE device that is not bound
to the "optee" driver before calling dev_get_priv(). So nothing reads
the field from a sandbox device.

Btw, the series builds with -Werror for sandbox_defconfig, for sandbox with
CONFIG_SUPPORT_EMMC_RPMB=3Dy (so rpmb.c is built next to the sandbox TEE
driver) and for qemu_arm64 with OPTEE and SUPPORT_EMMC_RPMB.

>
> >
> >  struct optee_msg_arg;
> > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> > index d4abc48f764..a40573c9281 100644
> > --- a/drivers/tee/optee/rpmb.c
> > +++ b/drivers/tee/optee/rpmb.c
> > @@ -210,6 +210,7 @@ void optee_suppl_rpmb_release(struct udevice *dev)
> >
> >  void optee_rpmb_available(void)
> >  {
> > +       struct optee_private *priv;
> >         struct udevice *dev;
> >         struct uclass *uc;
> >         u32 tee_sess;
> > @@ -219,6 +220,16 @@ void optee_rpmb_available(void)
> >                     !device_active(dev))
> >                         continue;
> >
> > +               /*
> > +                * mmc_init() may run from the RPMB supplicant itself, =
while
> > +                * OP-TEE is blocked in that RPC and holds its RPMB loc=
k. A
> > +                * nested call would then deadlock, and OP-TEE is about=
 to use
> > +                * the device anyway.
> > +                */
> > +               priv =3D dev_get_priv(dev);
> > +               if (priv->in_supplicant)
> > +                       continue;
> > +
> >                 if (optee_open_enum_session(dev, &tee_sess) !=3D 0)
> >                         continue;
> >
> >
> > --
> > 2.53.0
> >
