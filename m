Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5BD606A334
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LrTyuN9g;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmA0aXnI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E7468116E;
	Fri, 30 Oct 2026 14:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eqjHyFHHX2OW; Fri, 30 Oct 2026 14:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D08B28116A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793369148;
	b=aKjegv8S/+nnVio/eJiC1+YD1T7xDt7OThqWDrHP7qjpWI40EnN1yZCW2fMU0ER+QE7G
	 HND+chn2coBveGsK8y3gYTP/3mUjrJwiltqrU3vRDGwUO4O07cCHwfg/Mua3QtRgzqcP2
	 kzQtZvULx3o6A7nahBn+KiRT2x+Gysbtnv70K3bM03H7rYYjzdswFAVC8X2UT0JV9op/i
	 s+vudBh7bM49pMMYPCU2uTQXM57NkXnMbgUT8lDk2TFaqg+8uiYXpI2TVDcn5rQ1agppe
	 QUEKRmzya7wz7ujNHDAlDDy46KdvdptnxRnTYRdIK9sLTCc8RFHVM+f/PCS2Hfs63Jg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793369148;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=q8agKY2VD26P/UkqAK5E1B3lOmnQ02p6JgmQP9qKuvo=;
	b=PDztiWMhXV0RJOwTfIGCg5l11b3dIraUvmJBl3cTJYSb64Bhcb+5PItdGM1eYALQRXpX
	 y3Y8du94FDmb0LTlEGCKmnI+hw+WHVOoJEsFKHTK1Pn+UWzrEUGyvUCFEdTxEb/V7oekm
	 9+CUgucKyTk1hnIC5/4IPZy5YuKNyCG7do6xp2ybc2+uMTs1xJVnesEguN78T6mhAIHa4
	 4C9teUxoR5fB5ZSxARZ1rM6MxhAn9cAwfS+jxaKNNtQ0YDOKjmb3B2ju6Sd0x3cyaDf1q
	 o17yOF9lWWxgQzHgGcxEeS7ROwt5QJArgugcBjq1eBoicjPgx6XtcZqjWEr9IvVjU1w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793369148;
	bh=q8agKY2VD26P/UkqAK5E1B3lOmnQ02p6JgmQP9qKuvo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LrTyuN9g8k1wfYMVt5/8zQR29fE+i9Ac0KN4NtG8ncFd1Qqh+Gc3on0jDY/sbX/Ls
	 /RqTaG6tPv1Dc53NqwdATBYQa6iNl7mLPRxGwkknCWKaOwgxPsu0yAY4jv2k6/98JE
	 2oDkYmCZpxVI/0Rl2cL5D/jrNtgaLd6OYLdjiE4bma0CCdelzTotq+dLMdJFP2Rqjd
	 5UHM6rWdnfynw5CWbJFvtM308UWTwoa0QRpUosHF9eNwg2gDlnD3sFI5yJv3OK76zi
	 uucO+KtymAvBv1y4uPYHzEOiMFFsyzfw7jvJLEU3PmSktxqP6Nn2ZVQfXOk3i0cRjL
	 T2MlrfqTBJuCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D08B28116A;
	Fri, 30 Oct 2026 14:05:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8071F529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 712EF607AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:05:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFHIbxuY-V7I for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:05:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C798C607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793369146;
 b=BQNobCwRBTz/yRm6KunAYkzOra/wiQMfdi7FQTbMYwtwLvN81rHsjS7zhay32r5744xG
 INzygOuDxvTNN3P1jSvsoCqlWXL9R3eVkdhWbp8iugD3u5aFfi2K+qWH1MGjeOZE6Mi4d
 8/2i1Tltov3OBzmgRedJMcOirGJpCl2SU5BZuQoUNmrNOazUsuHMs+YcUvCBD7p27dN15
 Z5/d4tk7RS7vX97fKguxPaWCIq8RoEJ0pLDNrwf4cMXr9lfgObc6A6AH7dJXQZRe18ETL
 wPKXHgzZWRipGW8j88LbpUubTWrpaBIAg71qkc3C5pVV2jhWlVaggHKqyWUiJKRzEcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793369146;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=q8agKY2VD26P/UkqAK5E1B3lOmnQ02p6JgmQP9qKuvo=;
 b=YpjOBSWXCXwH8NX6/GdB+qFYpxgU3a4czHnTP31wRmHxapdqefmWLPny5bxw5RPgnUth
 SyWw0DiRydDAyGCrTACthiMVuY0YCYKCvimAu7Ur6P3QxfdqViQrbBmDvN8d8yJiHRqtW
 YmM+qwKYuMilwG0PQv+XKmLxjzUEar9R9jvXLExT3hqQ4yJmlig4tCm7mvJHgzq8by4Kn
 w1J/Y68hrMgqFZRfDTZseeu6Rxqt1AtGndFfS2oEbsuEp2bZIBgFJQPSc4lpYYl6M4YRr
 JDqi02G2eNUInvKOvJcaR2dUliL5hVTGqLJvBKObLDPjD2rto+0AFy6j6ZZp3tTqgFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PmA0aXnI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=PmA0aXnI
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C798C607A0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:05:45 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-845f3fa7f38so330068a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793369144; cv=none;
 d=google.com; s=arc-20260327;
 b=ByosWQOjln2w5HWHO6zYiMYv0B9sPRs+VXLiYDy3WU2o8h05+lsPPHePiGIqQtMdHl
 NhJx48jd2TLI8j9LT449z1t90mJPZuFCglKrZPB3xXocx3feqtF2gWcBr59iU/cmTEYi
 zTgrABouor/mFMNhpBJ4FKjg9Z/Fu5GXwYPmMhhF/YV2PWhfJKd2DxSSwbk+jVdVqT3Y
 9xlBv8uFt4/FS9A5+8SKXhCERRK2MJ+x1vXacx6mLIQbXS/jhNB2aNNHle5gn7r4N+Qf
 xeP/4N/RMMlUVncveTeIm6Tos07e7GdGyiqKlNuw/AZcH7tp0MivvoZZZZHLAzs2DFmn
 IMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=q8agKY2VD26P/UkqAK5E1B3lOmnQ02p6JgmQP9qKuvo=;
 fh=wMOKBfT7PYrHfqbDKLg0eNsbKfP+M9S5vMMVDBXma3Y=;
 b=nu9yE/YpX1NnODr7emob7/pWnMp/65vPYoNKflaeamjox7yDZ13GcH2u77dDOjknKN
 U2n6I+Uw5IdOFP3g5F4xeTAeev/eyCl+w482qoGOCl4XSlbMahKPybMgHvXj8c+9+6rK
 NpNdNcZsIvAnvslo8A2XBPyzZn+/Oy86md2B3d/M+fheaMRjAlnidcMZDABpN8QCg1tB
 rTDfelYj6P5AK4hDMhpWxxJ8COUZne9GbYcE2q3tV/2EkZesOCRMovTiL0iZor4QDSUG
 2WCUMvhwSEuvZKMWae1sOBtSQNNDDSu3H5WPPIqAeYuf9+pE+r2Kvej0VLtdTE9m4jSu
 nX6A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793369144; x=1793973944;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q8agKY2VD26P/UkqAK5E1B3lOmnQ02p6JgmQP9qKuvo=;
 b=PmA0aXnIi98lQcHwt2cLOeADxECf0UBLFtJeQU/WmXw+ZcmzEmcOpTD4lAekUFBp1Q
 3IB21mnQX5u8dC/B0eBDniLRiO9d4JNOEyhCXVkEQ3vRXgOQ3oYYUgxpiHt61KWb64Cv
 UV3dM1ySKjz7JpcU4co8ndB9c9+8UVFfhS3LFGjqq0i8LQqHzF3EtPZ7UPwsbS5Fvtcx
 wTEg4VwGSDAtp0Z4UVUrs8EexK6hEFfG10h67BXkmGpdxWFeqIvWktNC6xORzxg9q39g
 fV3Sdb+rtKj3/RdGSqo1m/Gei478ty03Bu5Wpm6ShPk1FJVSi0peIzUjfszoNh917Ru1
 2olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793369144; x=1793973944;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q8agKY2VD26P/UkqAK5E1B3lOmnQ02p6JgmQP9qKuvo=;
 b=bwN6EEAYARwUZrZKxNcI0fIzKkIiSbAklYCU1cr2A1Ln4JQOeKS7o90H7y8Td7vZu+
 GOmEM5q8C//ZhttBQkTI3GEVtD609oJsXXL+4SYmi1XUoGK27/iVuaJH5sZ25UxjHMXu
 jkd/epimN/v5cVi8WqYRDxGLmikhxC9Ngmu9YIrE80351SE5Of4O+FEFJYWaTL9gcrgZ
 VHPVQuTxqKF6WqQjOihzumm8GLiiN1qsNWxYDKqrBnCDT/B30yV4hLS8jBqt7AtKSGex
 8C9ZSAlD9haZGs8BOy5t973vhJDopQxkOnZWrEnSdgyp5SuJD7ENcmY3EFCiC0iOgTUH
 YO6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe10ktqpRRlS5IWXp1h02PONntMHhLyXvLOgnAoqoNQ954NvuRUJRSWPM/jTUBpza3sXUvClA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYILy5o3m9ph5einMYQ8wahMHFyLmcsMWWaG9T/ZmXtmvIIVwdTT
 803WxfxEeYRYoT2xjSdnROwDQtr8KUAOubLlNtJH6cymr91MB+II5AE+mb4RUc3u4I26My5ioZm
 e9sjTxQSVBkQ1vx9h05D5T8whElX+dAk=
X-Gm-Gg: AYBFou1CUXX8tteTWhxRO5HcPIWblTD4LeRNP/NsGvjLmbAnEZHF9R2HUQLWm/lQ0sR
 BgYp4bzzxm7/v2Un53Cmt+XytbTTHZEdFcSnlqZ8pRL8McIQkoEHcsNE7wOaXMC2DLwdieAZyVi
 R246ZZLvVangSjNZa8iumJzqUrEtPQMt+VMSOMJVnWKHRDjyilZn8Jcl8QALDMyASPMSqgWj1yB
 nzRWvxvzvycBdnaWLzDMBBSxzL6pYVkQvoqQyRZwe/3HCxGYyyeQt18DtPo6vYi/GpmLALdWMuN
 d3BzokbJDrWCQywcImfvgjgXIiRDcoptUTqWlQnx4NwKu0qw2PWGKQUD3t/FEEv5UtPa7FGHmAU
 hDDuq/+EKpLprQhCbP3lrJgkJZC0+CoZOSctBJA==
X-Received: by 2002:a05:6808:3099:b0:551:eea6:9397 with SMTP id
 5614622812f47-5640de26014mr2016287b6e.59.1793369144227; Fri, 30 Oct 2026
 07:05:44 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 07:05:41 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 07:05:41 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <0488b054-751f-4de7-9cfe-7626e5444eb1@gmx.de>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <07737350-49e9-420c-992d-6a290c2e0d76@gmail.com>
 <0488b054-751f-4de7-9cfe-7626e5444eb1@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 07:05:41 -0700
X-Gm-Features: AclHuK_mGxUVP9us8HRSniZ-IlV1M81ViFI4UaDgawuWn5h1Jd5IY0k7fIv5j-s
Message-ID: <CAJnxHsi-rgYT3oKrO--Aq9iNKdoeP45VXaSGeVC5HHy-zjLp2g@mail.gmail.com>
Subject: Re: [PATCH 05/10] efi_loader: check that the PE headers fit into the
 loaded image
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On 10/30/26 14:09, Heinrich Schuchardt wrote:
> For secure boot we are looking at all regions. Shouldn't we make

This sentence got cut off. Could you finish it? If you meant that the
header copy should cover SizeOfHeaders, as the hashed regions do, I can
change that in v2.

>> +	hdr_size = (void *)(sections + num_sections) - efi;
>> +	if (hdr_size > virt_size) {
>> +		log_err("PE headers do not fit into the image\n");
>> +		return EFI_LOAD_ERROR;
>> +	}
>
> Shouldn't we ensure that we always allocate this amount of memory
> instead of failing here?

Yes, that is better. In v2 virt_size is raised to at least hdr_size, so
the headers always fit and such an image loads instead of being
refused. The test now checks that the loaded image holds the whole
section table.

Thanks,
Ana
