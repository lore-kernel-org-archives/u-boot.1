Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA72606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ee9dnspe;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EzZp5Uo9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AA6A60A6F;
	Thu, 29 Oct 2026 19:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P7HSbrP3_Jr4; Thu, 29 Oct 2026 19:25:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8FEE660616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793301915;
	b=M5dnoR90v4SZ3q4Bab0YLUYjtt7RfHNtCWA80Z+OyU+9uLeBWPjm4tpPUSrD9XCdkk6k
	 DiP1ip7M4QJErkdHSQaOmmb2BOtK8NkI8Zzct2ju2OSelXkKQfmJ2D9ZiytqrGKa39yeY
	 JzIdDDtbfKEQ2oxw55ycJ11urplXNKTn0nxptnXfLoORwuk4D2CdmNHMdSD0xabmGmm/2
	 +xaW0USLgLRLwEug6FYt5ayXyzhD4qV2mxJECuF35HBCJY0mfXNvcVlZz9Cx8H3njRb1Z
	 uHfqaaxaVSPLTQV6eA9agxSBa7JXsXJtnBx5TMxt42nUkCYpN4rBvLY+GhTPSKFc7aQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793301915;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0KUxi10PuLVnW4Cw1brT7GeuTl+fjqaPddO79iGJDc0=;
	b=T1ey14fERDufSAHNZQv+r8RR+TwwGI0aLP/zIlzwtQGKS93NakKPxE+NS4iupBOncFTU
	 9SwHG0lWFbGzDHkkYxXlmzc4erKRFE3jn1LMdBgRUSFaaGox+y9t4ARTI8x3k1qHzYZ+b
	 /epgdaY7wUtCUVIpaxMKqGdH0FTdhygHlR1dMwmGXYYTnveMwo5M4tnLqm2JhJ95BDdEd
	 w9sM8kU7XtdKNBnGrvqtJBEm5SAL6ZuIOp+M2BbISqqPkYjGer4K+6mHfN+WwEqVhPXs+
	 CCxQSlEcKIAAMMB1FQ5SAAmQE81ur6hqsyKg/eELWsueZd7VtFL7ZXu841xUCPAFawA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793301915;
	bh=0KUxi10PuLVnW4Cw1brT7GeuTl+fjqaPddO79iGJDc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ee9dnspeE8rQooiTh9vojZ09+kosImF6mn03urmc1cleY6v0oNMR8gPQzsQ+WPOdq
	 Sg26LyXsqLtzWrsy/IMPZMnYscfpGS0DFqu8Flfr/r59NsX5qI+lsaa+SGOFRNxpSe
	 Gr6I2QgRbsiVJN5w5EzaGoxDR/POYyVm8Oj4xjxdnrpfzXEOfGeeK9YgtFasIeHsjQ
	 l6UbbdDOCLgfCWhisKnxl4NXR3DDYDbC4qb3kpLVvvefJJzgZ5jfAUDuTDU8rbLQmN
	 JxXaGa6X9cKn0+e0bPf2Tg8qvs13PCMd7vA7s+em8Y+ZtOrMP5rMfyAlxx4YiqNO26
	 iXx9T0RxHekmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FEE660616;
	Thu, 29 Oct 2026 19:25:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A092120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FE0540536
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:25:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s8efQBqU564E for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 19:25:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 804F94052D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793301913;
 b=Gly0HD1wheUwy7zlspJ9T1h0/NgD0BgjTffI2+rew1t7yndWG3FkZVheiCdRS9zfiaeP
 TKh6y2wu2J7QK6Y74n+5KXVUt/SANHpR3y4WmDEi/BMGLycHFqse436LVdoaVPJVeUDry
 o2vLNL4OH5ymiUGjyA00Lq3C12pA+e4vonaqUIPmygB2jZckjmukzftgXLYZ1jz38astn
 mMlDBtH8Fypb4EqIxFoRFgpC7ueO9ix032TrkNFuvLBMhWyJccNz9oVVvQBfVSdYoAiGl
 7a5RnvBwcEU/qgRvgqLyPXFtvgyKMi+gJxwJqX2gu4i98/Xi5X6uBHh9X/BbFjrIXDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793301913;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=0KUxi10PuLVnW4Cw1brT7GeuTl+fjqaPddO79iGJDc0=;
 b=A4onH03HIFUt3aLnEUzXoM+jN8nPEFgvWJACRFKnc+xK1V3Q7DQf3yuXhQ8vFr+GeVaa
 Mo2WGDfqivYipM/XqVD1f9JL8sfFOoep9DRxm9KVbtiCNftzPBowRDBs4U66EIP/lt4XP
 ywYB1OpKZ79101KcyaUBxKMmx1Bx21ZgI8a5hKo6cUk36wCZ2mUlpbTRVYajBmwjiarDZ
 IV0AVaqwPpWhGB6bPxkZ1TWjBFLgehKgwigJJI4/MBtKxQeNR4u5XBNRbfc9o57p59C0u
 ZUygOr/Ai67hdi7FHDfQvCvtzczKCPO0MIBqs26ZvIURRpFJwb6Q0iFSTkx2TSag87w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=EzZp5Uo9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=ryanbrue.dev@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=EzZp5Uo9
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 804F94052D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:25:12 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 006d021491bc7-705f006c508so486641eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793301911; x=1793906711;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0KUxi10PuLVnW4Cw1brT7GeuTl+fjqaPddO79iGJDc0=;
 b=EzZp5Uo9WGS0o26nTeI27dVzttMZ1UdqFq3kcXaoqsbeQLRwzbL2h9QL+a45VdPHnr
 m68yyvjpD1+jzjGjlWxNIyRDAlQJWepY/zKfZJzYut2klQtYqqqhCy9uj618lzSKKqwQ
 eecOCQrpk4u+Q4nlozPfz0foabBvNL31NWB0OXtpptiuHu4W2BKuGlIl73WqakQUSRIM
 XZirbTGlhZ2FEjQcZNCF3DOkfaeVObbYsb5qkfkHC39NweyyJYOucKGhp+UFnmJISNNv
 UpETUpIlwc5c+tqCGiAcKvkwqf0btPBUlQf9kWKEd5AGS5RgunngFJgecExOzw1rqVra
 xnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301911; x=1793906711;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0KUxi10PuLVnW4Cw1brT7GeuTl+fjqaPddO79iGJDc0=;
 b=PbnsvTe0IkAi6iDnC5z23R3rPyMOAEXZT8K46OgdXyATdhOK+06VEsJYt7OIn3MaRl
 HegWQhsInYr09Sf6OeBLiiUHV93Ik5kKawzPrPLMbsS1PIvXm4XkP7jXD6b+i0w8dMJe
 /5v4m4tJvX5EjCrt16w1zUMuvqK2wQNY+0SY6AeQbzcbhS9qVbYKFx41SqJZrNPI8Czg
 KH1WhvkPI9F3CLj9qAcz/dgZtRovFmnStZwzthmMbg5hNih1l1QzlEOvWW6iWyL8F+4z
 SPGu51I2AfuhLaLdgnSCxcTSINLM2fO4UO4jptiww7amkSuUqySBllNLiStIYRSFsvts
 1SQw==
X-Gm-Message-State: AFq9FYLN8pAX3767IE8dUBkBOLPLhkBeJUcwNY/un2y1Y2CYemIZT2Fe
 CrMq7PQhpRFcQyPs2PQDP3E0iQm2VSad4dTqoXsrRg+6Gx1wY9ojNVEo
X-Gm-Gg: AYBFou1DxvL3uHYyUILj04eJ0ubhZ+Gk18n+Q7jDLZ4crzX6o/pGQQr/Nel0jLfpjuF
 v/GjsOL1A5dhYZoJ5Hl4xS6g6JdnRYhzWZSIHJiWVqC77Pehkhm2Bp2b2Pp5O4YpliWdAAGwkcA
 P2B4BqdGCVEC/ygyHemLOPcE/iJ0wkEJn7f7p9beMFR2wS049aHauvy969clbBWJ6RVVDDspo+E
 rUEEdCrwRhAk8iW03KUJ+kyUrO/F2AtyppmhbnyQpFVclP9JKYByWdlYrQJT1K7H2AlZZVXLvZ+
 5oSQqXUZ1Os8Fxj0btkb28gGfhlJ8iKxOSm5lFzG6UAXJFK6mZNKthXZqP1cHWLsYmRePNnACU0
 fvJFDYQoCZeZVlOwnywfdTBv+YDML39gOEmQ8Mif7/MoowNNRIn5BI1lgGzrFhwrf1xqNsME+26
 7XR8FLf9f1ttkz2hTCx70wzHJSKs5kzq5yh56eLMAtvZY0C8rM9mEnqzQZtA/84giZ+QNRAs3JE
 TatqJVy088Bvvc2WRFPVTlb6DHW49fDQ6IxHjy5cxkyqDGvC90njfa0X1HBgkhW61dZBW0wtUeu
 bSZO5nU1W8MC77Ld4OOB2pLVjYNKILs2cOHRDeTVnlk=
X-Received: by 2002:a05:6820:160b:b0:709:a86c:7c70 with SMTP id
 006d021491bc7-714f29746edmr185083eaf.48.1793301910978; 
 Thu, 29 Oct 2026 12:25:10 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::c33? ([2600:8804:5716:d800::c33])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a904477612sm312988fac.1.2026.10.29.12.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:25:10 -0700 (PDT)
Message-ID: <a36ddb19-39c7-41dc-9a24-eed0a8e16276@gmail.com>
Date: Thu, 29 Oct 2026 14:25:08 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] misc: Provide stubs when MISC is disabled
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>
References: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
 <20261029142711.GB2976463@bill-the-cat>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261029142711.GB2976463@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 9:27 AM, Tom Rini wrote:
> Thank you for disclosing using an LLM. LLMs are discouraged in the
> project, but this looks fine.


No problem, it's a pet peeve of mine when people skirt around 
disclosure. I couldn't find a U-Boot policy for LLM usage when I looked 
(I'm sure I'm not the only one looking to make sure I'm following the 
rules). I'll keep that in mind in the future, thanks! :)


Best regards,

Ryan Brue

