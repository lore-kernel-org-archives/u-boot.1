Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B4606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WCHNbGO5;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tBEMrNm3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B59B40AAD;
	Fri, 30 Oct 2026 07:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOn1X8qgW251; Fri, 30 Oct 2026 07:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BFCDF40A5B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793345048;
	b=JHgp6rlpcEjAMMsuN6DeXNai+6yoF9KTQdQv/fT9sb6G8qkHI4eWWJTP3GmtDZKDA7ZF
	 rtge0S+UPDa5GN18iLiyAVrreJlhiNGdf0OYNQjFrAf0GN4O88jdNmcu8s6QasfGH7GDH
	 aG3AuV60hAIymcdtHW782q7Ht0Zb1QIKR6WsIZKypGgfOj5tEJ+PGoCDj2++OY2EyWASL
	 uZi/mynJB+i2OcNvEWT58wnS7DEJfJPe9vH7KdH33AW+zdjhy/x++7t5VzVS6BsfYYxKb
	 K5iMi3pT60w2BPgwEOW3+LQb09ioGjTWt/PdAclUdzaHcFJsvJ8Y0/vQ0sqtX/6rQwQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793345048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nteY4ZSM+3sqdnUYn2XSuSFsQyd+m7XTrICoISA0wpE=;
	b=X3t57St1IaxuyUULp5ocH73e7kBQLxg8Hyhon5xIMrqw6PzON11CA1gt2NFBaPWa/zAD
	 N1TrQER4QcrXXagijFo3mBiBvd9B7jAPl8LKaoWGJAKZdncoEsrgVCCZJ6D1HBYPQlUni
	 LLcanaVb/JKF9XqcRxvXGj3gAOEk+HHDqifDy/heYvN9I4rOz/eJo4ZCdjpLorR1U0Mdg
	 4goG8YirMmgP79FynRh7SWQP9hw/RaZlxJptb6PIJXMXy8qDg4Is0XIaKvWPPrFGS1s9f
	 xTt6F0P0Yf0p5PYDobwT8Csa3ZuWCyRaW9/SDDmclTpi6iGJIR5tsPfrX7Jxh1FFkmQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tBEMrNm3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793345048;
	bh=nteY4ZSM+3sqdnUYn2XSuSFsQyd+m7XTrICoISA0wpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WCHNbGO57iGSfGlj4vTTbd7z1xkAQrOKK5Jlgh1cs8MjozaC/fTSO293x5uViYijW
	 VvX7LmopyrxHZagQc8er38lrtTlp3yGN5uO77+ec5t0ZyAebZg4IY0LgfjjLbpt4v7
	 DvNYUmj5pq5yi1A+EfcbJfuP59Y+jUtg8Zb4tdOfDdatF/Kzklw0k9/r4EAwlrH8QX
	 7W9PmK7kfIs1f4U1CsRd2Mtd9R2RChbhOAFInVKX+wunHMokqLqiwpMQbNKBxC6zBN
	 uskri8JWXANuzi7RLFGAPdMSKG1B0viYxt2s8HoMu9llqmS6waQy7SatuOvQo1gl9n
	 UP9denZ1uPRdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFCDF40A5B;
	Fri, 30 Oct 2026 07:24:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90C6E3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81FEC40A5B
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RUQGil1T6nii for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:24:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A8D7640462
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793345047;
 b=T0S+0jcVs3zt3hZGoprWAMXOvFSGcq29x3mHpAqmhiW6Ia4/TbzD5H5N0U5KJDbtwhkV
 1Zd1KvQqoYA46eN2ZdADl+I0bHKZcZvztAGyDJg+H8NnrlbwpwFuGf6QAO6JaoxW3vMha
 /3TWqqMvA54SD8b3jB+2jzcQdX8sjUwShIwr7iJBeVVjcvgjKsP+WwrC8gBOwKyC9ftLh
 Jplb/GhiDbppSQcBUgwN6Sz/0eUsZXrN0e15NJv0rUafixsvDENjZA+QR6bea+b2ybO1c
 npp9T9Ep+EX+Uj6V2E2ZabzGG+PMsfo7R30RZHefiUpqub7iJuYEh71dz1PUPE1CjSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793345047;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=nteY4ZSM+3sqdnUYn2XSuSFsQyd+m7XTrICoISA0wpE=;
 b=oNz4ZRLYg2uW/t0lt6WloAfE2c/v/05+9r3xsTtXiJww7HIW5+sGq5P1fr5FQMvBFlOU
 syNIllCPRyONUXjl6sa5mUR/MAmTDKK2W2TroeUB3+I5sv8QOY9IYMa8QbWTPmVgwCVSO
 uPmh2dIrXpxq6hA6IiSapUR0gC5LQkhhXTxmqsFv/w7aq3Yvg7eDvR+ZklJXul4NagkgV
 vKRifz4WB1ix6B1JNLsVsu7Flusgvn420Nh/RdGCODvJQsS0o0oD0ZlE7fc73o0ujRekF
 OQsIQJ5adQrCFe0IC/8cCrHAqiFa4vFdkeVs+MPLHhry6KXRnTYqn4zZK1jjkosuvZg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tBEMrNm3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tBEMrNm3
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8D7640462
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:24:06 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b06c0794cfso4030167b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793345045; cv=none;
 d=google.com; s=arc-20260327;
 b=owtQzA9CrZ3fqLE6qks4Vhl0fHCFLJawoxw6VBMyZOxDuYhKPbpY7yxuO0F6GpVHV4
 SuhcVyq8RShtFCrgdQq7MPjw39wNl5EfzSvG0kOoL9cct1UqFSy7WXaOmI+E93ZTIDKh
 it6qylQJeRMo8NDq2NEHsrPO5GkOq6R1RSEzrPLXf/FHcqJFtBHXWT1xt2QPrreCAsZ6
 HtcO0Q3NcB/qS+Y1CF0HyZwM2sVqDdqmeozETrxZVnok2Vr4tt95i724SyUzkoo8uo/b
 vISDACiKpYCek4KX/9nn4fSRESCgfcz0QwaSpRrQZNX+YgzXABQZbtfJ/fdXzIzGaYyj
 RAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nteY4ZSM+3sqdnUYn2XSuSFsQyd+m7XTrICoISA0wpE=;
 fh=OhOSfS6mWstEu/irkSxD71iDNWnMeRBAfsy0D3wuTYI=;
 b=BDOjC7p5tTCfHUS1192EJ+VOnzkLl86Dy3fdG71+w2Kv/gFEYbIeD1Q9XjH7k6g7z4
 gsM2vXQJ+HqS07ymiU1XnLqMMtrJUnR3ZBehrTf3G5fJN//SEA6B3I3b01885ehUfDyu
 H7vO/RvI0gnFoK/QGSoqdFQ/jOLgSOWuFcGYouOXbO3cqLHUu4e7n3pVBHQ7/W15RRPf
 FR4F+OoLjy8jXpaizBc1aJa61pNznZVCAoefeHuwBmoFwCR0Hfi7+hvZNK8yLTPcQTP3
 d1Qit2MoA1VqKiwCcuAQydtN/XpP7JRCoToTZrlmJTQyATnWLU68OyzniM0TNm379P3c
 kdYw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793345045; x=1793949845;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nteY4ZSM+3sqdnUYn2XSuSFsQyd+m7XTrICoISA0wpE=;
 b=tBEMrNm3JZ/S9GnJv2A0Cd8UOGLdpmwrwhtvqQyN7O/4amoyafEwRVADqK1MzcMLzk
 5NsNoJeCJdFsy8Tl0dxD2BTf/4UUE3Qd6Fyynk59CKmFVUuP3GxJQKggyF4ykjRrYkr9
 G4aojxPDfT7WErqO58gD6t7lR3s++H9c367SXNXPVM8zbOm+0NGIAO/9vJl5BLsl0+8B
 T42Ve5L5p+JOtiozdZIXDZI9+fhnVnC4JkwhBZtN5YNSCqn1BfPRzly5D9KsfKaYf42L
 YqBva+dZQEK/FHJdhkALOPNzVVDcJ+BV0maxqTfuAZtbj6y4bqDu5O+wDw4WepBejjTF
 hmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345045; x=1793949845;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nteY4ZSM+3sqdnUYn2XSuSFsQyd+m7XTrICoISA0wpE=;
 b=w2+5xIZE/dA+FVZh2XFaPvmlpuisaKBUQ7p/8XA1qOaGHKmMQx9fzgkyGd2age9TKY
 Q5/NsYAJLSsjyPxCmTXYCdvxPtJfbwCFI+guFXqpwcFuIgOhkd7FRjvu7c7EggKPACu/
 r0D98ouiX+FgJohkSJi5t3IFKSFLfEYlFAjyG+m0DP58b/FZqoCoR3dwDOochdL9kA4O
 y/UkDPrkXPocgUQSxd4PeV7PnEJB9eYFqn4ZZAl5PmlBxU89GOkg6Pzxnw3BYwciaHVn
 4kz7PTsVnRP1lg+u54qSHttIM1Y1GoSq8mc9Hpst9Su27Gro/AH0wz7FTsvV7i3o0SgP
 IJAg==
X-Gm-Message-State: AFq9FYI9ZhUZgA/Eqc+nTTSZH8j2Yp7EHtBBJouFXftuTtZyumZsfEDz
 3AkdxAFxR4BVzcqWVZdVQoareOSLwaNvx9SvRCCpUUKZ/7sf+1e1EDFT/RaD+UaCbn98K7YTZ3Z
 CK7+4BoEdDNKA72yJDNy14rMyf5+gL9eDPczT7lfowA==
X-Gm-Gg: AYBFou1AggDQxRdQ434Jvt+0p9M87uu+KhdG6+ZxV5w2YDQ1OZzD3hu2ZbdAA4KWmtl
 +8OGQMKW/K1JlkSpv/+WwxN6Vqy0fqRhvijsfYY6qUWTP4JnEEZ/3rF7/rEQkx+Lqk/LYTQb9SC
 Xkw2tEcQ2llQvDgq9CZ5Ty4Nkcz15RrScUKZrjlqGNo7UHlB6vOJ+okLIRwPUAAnymLbe5iLK5f
 oyNWhzBJsadesNc1KF28U9sTbrXCDUL1LketD7QA1rK4RvqmjXnSdS2sy9u6rEzomz7/NqV4B2d
 Ym6kU++NrfwWdWS1dzlMCM2kjrT4FvEH3DHj0r5M9hPG2Zn0+xDOGRHCjVBe/EOqh629lVdYOfd
 GCQgZH6UkPxVUUOCS12n27u6a/y2XkpNwq33nTdxmperz3uGveh84VLhrffLJUrU77oD/Mx5PSY
 Swi887d/7CGMf1F7Il/OcLyprhVh33MLZ9YGdiKCFNpi7T0VIPH7Bs/kBD4W79Rs8Hij7li7kma
 6rqoxhbY+KF3noheoXsiUbdpZUrq0DluMXXHGSB+T0XBG9E1317gNTDRNg4iadv1m2Ye34qOQOQ
 ea5f0MCLwjWq3RptDFedCHmyqIY2zDBYhgW7RQLCUmD3p2T/Mt/k/ReE/2m0nAceelb2Lw20Qnh
 R9kATU9jWYq2H1f6niRpErpxxobjiSB1VchUWiLw08J1D6m7c519i/JdXeuZOJkh3e/MNXNSXVH
 3MhRag3NOEJsNf31duomO4QJuWXvjpZWKKgjU=
X-Received: by 2002:a05:690c:dc9:b0:8a8:88f1:b4d4 with SMTP id
 00721157ae682-8b2b674fe8fmr11061167b3.43.1793345044642; Fri, 30 Oct 2026
 00:24:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <b0084d2f-a136-4032-96ed-c4a03e392259@gmail.com>
In-Reply-To: <b0084d2f-a136-4032-96ed-c4a03e392259@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Oct 2026 09:23:28 +0200
X-Gm-Features: AclHuK_DrO_M0-FecRpF_MaAu65_Ku8BTETQnjk7Gj3WOvkqHrZhQpm3-AAwk-k
Message-ID: <CAC_iWjLm5LOSPfxgF_7Bj4BcOMiwDFY3+cdd4Wqerrqo9aA6Xw@mail.gmail.com>
Subject: Re: [PATCH 01/10] efi_loader: check the NT header size in
 efi_check_pe()
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 08:13, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> efi_check_pe() is meant to check that the image holds a 64bit NT header,
> which is longer than a 32bit one, as its comment says. Since commit
> 5dad05a0e61d ("efi_loader: carve out efi_check_pe()") it checks for a
> 32bit one only, so the callers read the optional header fields and data
> directories of a PE32+ image past the end of a truncated image. The
> addition of e_lfanew can also wrap around on 32bit systems.
>
> Check for the size of the 64bit NT header again, without wrapping.
>
> Fixes: 5dad05a0e61d ("efi_loader: carve out efi_check_pe()")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  lib/efi_loader/efi_image_loader.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index f9a2d2df405..e31493d5135 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -849,7 +849,8 @@ efi_status_t efi_check_pe(void *buffer, size_t size, void **nt_header)
>          * least one section header follows we only need to check for the length
>          * of the 64bit header which is longer than the 32bit header.
>          */
> -       if (size < dos->e_lfanew + sizeof(IMAGE_NT_HEADERS32))
> +       if (dos->e_lfanew > size ||
> +           size - dos->e_lfanew < sizeof(IMAGE_NT_HEADERS64))
>                 return EFI_INVALID_PARAMETER;
>         nt = (IMAGE_NT_HEADERS32 *)((u8 *)buffer + dos->e_lfanew);
>
