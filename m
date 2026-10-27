Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D151606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ePjUEzSf;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pGh7mPwt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3413480D66;
	Tue, 27 Oct 2026 11:50:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gWdB86vHJmNM; Tue, 27 Oct 2026 11:50:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 682CE80BE9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793101812;
	b=mXtVqqAkpqGlLY6wn93p4spAh7FGM+Je88WbfwES6Pgd9n9SLZcCByzIp8u2HeDAE3Xb
	 Se98vNEGEKYsP0J9ViPOCKBch+J83pqfpTHC8DvMpOcggV7UpZnE570Y10/SUJDgbFIcQ
	 MZ8DenDXERM9gVDwBpPWvAwCLR04QySY32XTE9Ae82ToDuVfcI8Z449L0p7S8s36A/XnQ
	 QonHztmBPxbYvqdDP6oLzt4kq1xq6PZGN1zbuCJNSBquvrlbS45/HQkZ8gltFvCijXAMC
	 V5b8wBPkxvUTEnRPg9DEqcZ843+jNR8d/8DLDq3/HQBiFWp6DUaqkh4PYhEdvQuS8tQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793101812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FJ3+LTVHPIUP/fltbXp3xzpvO3pAAsgrFWfvrO52kps=;
	b=NSM8q7Iy0C+snkg7Clx5mUQcSTa6a9QWwn57tIQK2za9hNwCvs/pcAY5JmeXr7LcFVRX
	 fNq4SVrRGnhl6QxtF7vcSffMBhJVkuveyfRS89JMOq6h+vj6nQN+BPJGIQPQGzYdc7j11
	 W/m1ZXKY8vzKL+WqgBpCd/ArJiKag60v/+8FlbgU5zKVnO81xlJVEo8uvZ0QHQHo4oMnU
	 C4nHSC6TYd/UQ+kHl2ICWwIsC7zEOKFhLOIelv9WiM+g1cufgNasnEIhyKi3qx/CcpCP1
	 AndPXG6+vOOd6VFyCITbLtws2xvp18+48LQSRnWyw5dLwnKoZCl3KS9lJECU2v9hi/g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pGh7mPwt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793101812;
	bh=FJ3+LTVHPIUP/fltbXp3xzpvO3pAAsgrFWfvrO52kps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ePjUEzSfuMn1u1968t4g3Q3oN2H1tV6MW/inzL4EoFmyQLSMzMzbPg6sV6LTFsJim
	 d5yL0ybqBWnRCFhcGqd3l5ZBs4xOW+YTQHCZHdd8efZ8i4aztUNQjBWwRPevQkUO+m
	 T0BzEm/46xkHXH89ovRPv0zPTYrLjtB7BpQ4ZKwXwU6ZuNZYvE/o+Ofn/524ZxSX/Z
	 XzZPf7n/Th4yvyfQpEC9OImqL4jJ8JmOd9WIIO0LZ8mwpbl0LQaE1SZYTKAUSbzYKx
	 uBHZraaF1w/IstOYzc3JTW3d45ehmnqCffoOZ2GGF9SQPeVbVyZt/irGCOH7eA0Kit
	 lM6DVJfN7Lv6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 682CE80BE9;
	Tue, 27 Oct 2026 11:50:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A7A861DE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9949B80D59
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ly0IU4SteS46 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 11:50:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B881E80BB8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793101810;
 b=bUEttQKZK4ZDCfvVb53Dwv8DPuON7ajMXYHyHwcCKRJhKqgbdbUgJk1plW0R1v4MJXAp
 YUW7wA9cyQBXzMKJcNlgEXN9GGCr2B7pLxdwEdi8XgGzWKsO6itUKWYMpMfbKh2EZC7LF
 8yrfXMk65Yv6ewMvKAw3/+SqhIGH2TaEB4TdKEnIam/+ZOkjM+TIxtymYTxIKhwRJcESE
 2d6f9M6IhxBWwYGuyxUvR3r+UCZRFzup5ezLy4tKu3vcOy/szuWz3QJ0JN342/1PFlnon
 qVgY4/JwidWx0Nf53fckawYn0gGa+yacODcwoZ9CBs9q02t+jV6aER9bGMsJ8Z8/Qzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793101810;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=FJ3+LTVHPIUP/fltbXp3xzpvO3pAAsgrFWfvrO52kps=;
 b=I1wCTz4d5HudFq83ZfDYaDP7/FXGUTpp8vFy8NJF4GciP5m6PvGJQ6OTCyvpxCw5OYtj
 qnpSZ8ns55jDUUO+0HP0iKASsT/o3DONemeQ7KfYD15Pu14pIS/xihdUIXr51vnkomooK
 Sd2nY+iunl0FU63QM079yXHm0UuLNStcy5cT/0ezvfP7wJI01Fw8nSIqPzMXScEnpmgKp
 Hk3J/qmn2OmH4hmqGsVkEgsY/X5YKll96KsGbzi3PlGGwWDay4D3wK6ujwye+H049wLzI
 o7fSI7rzcfckjzbrAR6yPZeVQ+6fMTDHsydflI4BznLsxgLsPlgF6bO0oJuw+zj2JRg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=pGh7mPwt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=pGh7mPwt
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B881E80BB8
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:50:09 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8acda240937so32534267b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 04:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793101808; cv=none;
 d=google.com; s=arc-20260327;
 b=Yu0FEXUhP+5LTPteM5ztvKvLRabw3AWzHpkIY9FcqK9qskE/ZjngnWd8DiS6X9P5PQ
 zrcrjpcqRYVmdFv9xCCgnyW8s/QVUT7OK4IZKOHzhHse/0OZJhnzmr7weCCkJHcOvmxU
 LjmWkhcMWlY+GPZ2sJRPuU234Z+nUjtBmhZARdrFZJxdORGf9p7UJUJF0z8zzeHoeP2O
 lIU5Pn5XLhJePgXFBtpW5ucjt+R3w5fYt5Ti99RVfPUxyocE8JISgXKF/UWtRGDRgFe9
 LtYNja5DUerNTDMagIJ9xnNsq+la2AP54Fh9Kh7ihI8w6K4B4Ycsn8wY3i02psZDYzxe
 dx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FJ3+LTVHPIUP/fltbXp3xzpvO3pAAsgrFWfvrO52kps=;
 fh=PLlHhebYnfV50F2Mjq5I/xqUKwVTSQ2ZVR6unjvaT78=;
 b=hDHKczoIx7MLdvuz8komEA301oGo8KCNchZiUh8mDzqmS9i+Pqb6xBW1XMfy7N9oY8
 Drk9gfvHbpvVGInww6QOgUc0GOirEW/f3njXXlkscLkfy5SOnWVmI/csOEPi35lQfiF8
 k427oH08x7TO7scxv2jMm1aCj3RJLZSfp0XBT+8YamjLXhi1oIwwV4LmEPNcrQVIQFwC
 x5dqz2gPpgtem2sL/pzAyVVzmX4LJ61zvey9hH9hjxcbWwaprHp4lS5FtgP5FYuPvUBn
 Px/khanPyuVkLwnFsgDifrlY6xYZAcFA+A+OB4mI15GVxZLpDAlSldI7/A4ePObUIsWZ
 LvHw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793101808; x=1793706608;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FJ3+LTVHPIUP/fltbXp3xzpvO3pAAsgrFWfvrO52kps=;
 b=pGh7mPwtpP1NDSmWcbOXGKhztOBlm3GmlUoDoTG/PMHDDkXS7BDO7RpHJYjiCKnV9c
 ZZSDy6yA/sYaei6MmPE1JJ/Erf4BGrozwr10hE6GE3L51lG+jYyRtHmq0jLRvxH7PzcS
 hkFMBnRVI4tDxRxzF6+iEboX0m/ektfJTzPqui7eg0TeMrctZc8ZCQc4MnM+E3pMclCu
 nWyjYHvdiFO9XaiplIO0nIwNXqnDiIxpHby0xgjdvpFrO0Ye0Kn/BEXPBHDOhxLUx1i2
 mFI1Eb/NWEDwhEph3IeQBrFvCh+H51OSZILhBiW1smOUkTR3re/t1SfYgRufx6ya98ki
 COGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101808; x=1793706608;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FJ3+LTVHPIUP/fltbXp3xzpvO3pAAsgrFWfvrO52kps=;
 b=oBbgmNxwxkQgHi29G3YXi5gDKvp9yHOcRcZDJKuhtMkEYFtNf/a9KjKbgxh+CcEBE5
 cxCqfmkRzI1aVqfgCl/1TJAROpD3ZXGZvxJ3JgFD1jPhlmUqAXaTe+Q2mhm5p6a+pRVY
 lhNLPkTXeShuccjsojn9qYEmbPviIKSTZ40CWFa4BWiys4hRRD9ut/Bc6UDghE4uQ/be
 ubW690M6HWxyR4s3icNtNFOr1ZgAHn4g9m0b34BH+Kk36ycms5/fkgUsmDrOJ831ed6P
 yZHjf8mc/jVxkjk2OJjyIPsT/LZxRbVmPz3neLgdnkSlL0W5mulI+SWOaaXONULUIxZf
 fN7g==
X-Gm-Message-State: AFq9FYKo0Dz2T0vdB1GebJb+efo749Xlc0sSt2vAZtOhtN8VapVUJB7G
 dYmXQ5NJbWG4z5wlDswMMnNtPAAE6SXR+nNsjb53rjiJ5VLO5l8wy6qPAh3Cfc2ZncoPQc+mKFU
 HDM1Lok40mxRTGIDerKZxrQlQXh0+JX5QlqMr88qKg+jDkjD/V/I3P2Zo3Q==
X-Gm-Gg: AYBFou3fsajaAQ23A1P2TzuEchmloFkJpfsWRpr2Palq+xcvTLp7/t+DWv2DX3QUkCG
 3OdiEIt5pGW2OhOXuZnY7S7jmHEaznatr/GVroAIHUVhFkAKaUY4Uq1xduENyoMhzfXd037TYax
 4DnjRhoCDM3lCTnwFE8viL7RVw8XlhmQHO1V+uzqaYM90PNegTY5h7HzgVdha8eMHzumE9va7SP
 IolDIhqQH7bTx6bb0tdYHeRolwRGepabxKyas05JwZouAITZoqgnaF6qIKhyF9NzcI2PKScNC41
 onxWBpfSAV8kl3xRH28KSoZafn+vpu6SOEPkUhGk2rjiscaBYvFLGDJOTt6w7W8bfHzFeSxDKv5
 MVhnFiGjbulu1Wd7BEmQQWEkVYU1di3m3PVcJTHxObwtHxrW/SOtCZQReOsTxoyQ+LmDacYW+Vz
 FftQ/g3sc14PzmaLa4Di1wlSWClV473FmohgQ2WY86VQr6RHPtTofdv0P4KJ4GCb7mLCHnvRCNf
 4BZX9Rr3rInVIBQRtXBCcfduk8DJfZBjJ1aAFzrO+7APyKnKPiKOkcLycgfAXtnfMlxEgR9XSXj
 1Kyqc3INunzKB38koQL7GcgFFNkAOvzo6PA8AkS635V8iQQjh6jHF0WZlTm6VI6Ugdd4o7w3Z9e
 Okk43r+1Zp/OweF3unN6JuEhkJ5rzV2TDfxxdbTiXbSc1c9orIlHVWgw71ZFtQK8VknpATcpBfe
 0L4n9qcF2cSZbIvQXPyOTf+x3bbpZKvubp709sdPK2hXvo/3gL6yRrwPBtJg==
X-Received: by 2002:a05:690c:a849:10b0:8b1:a33f:ce97 with SMTP id
 00721157ae682-8b1a33fdc86mr6555147b3.31.1793101807931; Tue, 27 Oct 2026
 04:50:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026201046.400670-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261026201046.400670-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Oct 2026 13:49:31 +0200
X-Gm-Features: AclHuK8Ls9OUKCGmcWZ7ZM8954VY8LZatE1aOzghtWlXDydt5fiAiaWK8WSdz7w
Message-ID: <CAC_iWjJ_TuNMTJwmCm_KRCzbhVTKF3LprtK3RpwC1VJNQ6Q+9w@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Do not warn about TEE_ERROR_NOT_IMPLEMENTED
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jens Wiklander <jenswi@kernel.org>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On Mon, 26 Oct 2026 at 22:10, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> If the RPMB is not implemented, then do not warn about it.
> This occurs with older OP-TEE OS 3.x :

I don't really ming getting this in, but is there no value in
TEE_ERROR_NOT_IMPLEMENTED?
IOW maybe we should move it to a dev_dbg?

Cheers
/Ilias
>
> => mmc dev 0
> optee optee: Enumeration command 0x2 failed: 0xffff0009
> switch to partitions #0, OK
> mmc0(part 0) is current device
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Jens Wiklander <jenswi@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/tee/optee/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index a47c76811cd..9b18310776d 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -112,7 +112,8 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
>
>         ret = tee_invoke_func(dev, &arg, 1, &param);
>         if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
> -               if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
> +               if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE &&
> +                   arg.ret != TEE_ERROR_NOT_IMPLEMENTED)
>                         dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
>                 else
>                         dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
> --
> 2.53.0
>
