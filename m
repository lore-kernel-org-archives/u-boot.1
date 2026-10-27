Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7CE606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wverxkz5;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AEPOlY+K
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6F5F8096C;
	Tue, 27 Oct 2026 14:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y4Z8ZB9g-9Vf; Tue, 27 Oct 2026 14:53:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2183E80980
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793112829;
	b=TTpPfJOFK4d93ed5GvStb39ZnEdnuPtcFTWcJ2k9D5+PbdN4+IHYB3ET05xLWpoxlnh2
	 WJvWCJZAsOpHjh6micEmy5mZA4oML2Ethf8PzuU4noauErRLDcblhf418vnsrmYMMUHn/
	 P3ewRfSGJMzo64nRtCTcjLJGFip/YyOL8iQNV6PERXEd0rJ6G36/q61zYjUVLRolEqbUh
	 4J2lcqxUuhSsBEJZZvniMu0JKssQhvqAud/tSdh4cuEOB2lEof9aKJplSJowDiik2NV5x
	 gKEl9waf3doOZrEIzwfMElprCslkun4YevVG3pFjZFxvMolfv8JnywBRV9RtwIh9YuQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793112829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4O/bHSzDnF+6qWNp2Vd1NJv19f6yAD0AfISYO6CGKoo=;
	b=nDz3lIrwumJ7219rQV/c4D7m/VQZqh9cveLvV2VhsFr+ZUIziAdQJrhYXENW6M21yJex
	 bD8eB5OdPewMZp0nyr18W5dxMHCriNHS84WHSv3LPaeJ6NcfkaS8UhBVyN8VP0uVlGQ5r
	 cX0UUpySGUbiDzTrruDdpTZfYxXpMWdd6lO2h7exgJfTB3zbxXLKubPaoNRBgUC0FjAi4
	 3fTYviApqO+CUB3zueoc/r2DPe9yRh950HWu05vYmLPq2C3JCsiCaDmR9M0SG3F9Kq1Pw
	 Ga3nm+PxC7hY7cs/XHGg3Gzp8r0BG5WIf+2qJO65tg9ljRJDnUtTx6+e8zhuaX/ZUvg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793112829;
	bh=4O/bHSzDnF+6qWNp2Vd1NJv19f6yAD0AfISYO6CGKoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wverxkz5jPf+vY+F+R38XqOUD1cK5gwhpM4bF1VmPCPB1w6SZuB3Ks18N7lbObO7o
	 m4ByM/4Z7U25YwnDwnxAzJo6Deneqg2LhWurN1Kl2Zf2nFz2zr5To8OiLXIMUMnE+X
	 ogUoy275kEiel6sqKeUPZS1U8Ub6FbEK76XvCJ4G4bXHSg3vIYre4TH25JnlBu5qvP
	 J7TpEfins8khD5vjQgCm0VUZvjpY7gLGyp2v0IRR1Yo3qEfQzcPJpyXuP3T1U9VoUp
	 1MbQvXvGcCKwVDnsXj37Gxghh858d53lKtFbBd8o2R3dFNXWLzjeg4SukerjC5/E/O
	 ux4mZ8U5RDCDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2183E80980;
	Tue, 27 Oct 2026 14:53:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DE96A32
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 140C560793
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qsb63kIeu5ax for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:53:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1C7F6064A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::234"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793112827;
 b=sYLEDZyY2lLZPxsWvEjEv36DkOyxsDXYNId5lVzicZPXFO0zm9WW59NKUc9j+pCNbG1n
 4MK1G2uY56/nZCtpfqpfZ61bHy4sO1Y3OSnllGJ80PpE7WQn9g3ZhblJ5hJLzJXaC7/Z6
 DyEtDJEx0qK+ehA9I8UYegi0IP1fHuuppP+yuBE1Er6IOS562AhdUrd7NFxb4BJE/SnEI
 9s9RzlWmMwbZPEGaAP8bTryiGcXrNCTzlUTOMxkFpW701nuuLBftOOopZMA9kqORyRzCT
 RWSlp8osY8XQ60wWjwkT0sSWohYEYqbgczjK3flfynghBMw2uWWEyiowZaQy2fkaJTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793112827;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=4O/bHSzDnF+6qWNp2Vd1NJv19f6yAD0AfISYO6CGKoo=;
 b=AgkqFzX00MsoOyIxGH9yuCCyEPqhilpWPaYhemNOy9LdXa1QS7lxRZRbjPuDWIwetfgE
 qaEW68qQY4exH18c9RFVRVGXTu1EMMfNjkKLWh8qaCTtEUbN1cHfwZL2CAA/kPE7gkkH4
 GTAzQE1ulqnJFzBht6GfubNQrTbjYA4bR4Z3CGeoAM2R5fQkUDEkv7wcszXypeDjont+I
 RKlFUuL3TV3+4sOvHQ2ysH5q6zdg5hd2ps2E7FdNAbvp76UwBZOYRBKCL0JLyEwfHAVD5
 XH0etwjv0ZdoxemA7cb2ddNk/MeGAX0Xkcsq+lOLLwX09gB4c3C39NaMCa+xomeM+MA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AEPOlY+K; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AEPOlY+K
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1C7F6064A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:53:46 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3ab28f3e4dcso9703221fa.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793112824; cv=none;
 d=google.com; s=arc-20260327;
 b=XEk6s7z6viYlt0hHtP9nb87Rj42l/8+ZffFPD3B73CG5Zp2b4OJQ9T2UGwxqO8zGKz
 ZGlEWU774ahiCvBeP2RkFzGJItA9liSgySIl5FrPLhgz3RKLYgMIOVZ6nec1x/l95tft
 vO8p1LMm0c2fh1p4XmqaRdJeCZCpOPufuUprf4lnn8q1zCkVtoj/QEUKTRK0pgFlzfMv
 bo2W+imJVZ4E+tqvYO2oO1ne90CP/AB9d5ujXUXVWASKWWPya1GeIiF/TbR1NTEblWnt
 rFztDpBZrXb4yKwWf7355ORSGEct1Kf+48N5TtZdKI1aaerswxJWsa5BevjhWbjeyECW
 rfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4O/bHSzDnF+6qWNp2Vd1NJv19f6yAD0AfISYO6CGKoo=;
 fh=DueMMB+bAqs33RQhVggobUqCOGNqHCsnAoRBN3+fLHs=;
 b=gqALeVl/T0cXiO8KIH6E6enJRFEcx6dPlC6nXzR6jXzZeb+qLidZ8o9KQ0Cqiy/k6h
 63uIXUn4kL9iM6Llxm70tFYKnRdOfJJZNbSAaxxNw6SYr6ONW+9nn3bse7zRgnxevVyR
 CzXCB04gvmU/eGCIXTzJH841RQTPHQorb8AWIGcoh1WVbzWF8zhZIuX7EmPzld8zJ/dI
 9lOzKrE7tyfYNm+FGDR+gHBhELFbFzLMJRF7lk4aegVfXgr0sT/vOd4EPrHDtN2mZb0R
 LivHWqbuIPumDMnea3PAMIzH+HvvtoBPirF7md9W6UOXHPYIYPz7cmj1/E9gMtIWX+Ir
 MKyQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793112824; x=1793717624;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4O/bHSzDnF+6qWNp2Vd1NJv19f6yAD0AfISYO6CGKoo=;
 b=AEPOlY+KbrAj4Lsi0GqjIFoPQU/+1dtHG0IZJRNKVT7v9GGs/xzkkeCIETgTYnNvx4
 +zpjih9I7jqHUN6l0EmxeOfNXQJ9QP9qBzHh+4j0uZ7+TUbx8zA5pkKsyHcE6J11/13N
 n91UB2EMumGfzUzqWfy04Q2DflJJTIC9D8Z6bgfqCh9D9YVK7zfENaCH2wzIPPuMRs8a
 B2V05xlvPJvYCbnkra/YJnwgeUAZW0EascIP+h6XQ5kRyTEjSZ2MSaMtnd6cbrHpUFKZ
 MzsewC2SceugCCCtWB8CqjZm6CpCltkRdnbQbNd3A0GD5YM5ghi1DVctep+GLWFt07pq
 xzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112824; x=1793717624;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4O/bHSzDnF+6qWNp2Vd1NJv19f6yAD0AfISYO6CGKoo=;
 b=a/XpNsjGnMzjpVFLc8fN9iMWBdwJkzvZmNQFXC+KIrZ1yk0ae3GgaWIaszKUWl6F1G
 5yqzbgtjyOk5LX/kfLO1c/T5hvuNPSiRk27lv5kCmAuAC4BqwnQ+YiujM0NgTii6VsoN
 +CfH48sUHHtct6h+lOr7M8fMi1fojJeax/Pzxt06aZmKZqqKoliz6Rte6n/TanPaWJYm
 qqqGp5IYmpGVqkq60TDOGrYbzgtungw2onq5woGaxyXJBAiTLZpSQ3fHuYAqrL4tYN55
 DtZHzwkwcmNhhd/WEt3LGDZNlcqqHFhadXe6TruovfyXKfuWa1QF+yPUWUrc+gzJtG1h
 w5mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByC87icw6IgOWathrMAl7h1QTZyL5idGLGPiMdtLvyFnEYO4q772rqWh2Dl5yJjFBhZTaI6K74=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKxXQnpQ95tp0E0IKUrkCS1e2gfv+0A/UajEsZz89w5qXo0HCQ8
 UYl3g7EsV3H+ZSPfUlCrjb1umvj961/jBwaFF1/wxl0fzlv14AivEgtbalgwsLEJNuz8XsMaLOm
 xCqqEnakDr5uC/VTOLaG1BFAlwJyQyTGY5Tt51v4oyQ==
X-Gm-Gg: AYBFou1cdY4tw+cXJ6210/9MO6hRIpfDoxpHsG2eAQHw7pNma6sAh+Unrs8/ADgo9gH
 RVNZQ2yAzw6NAmMpgaHx2uQRHja1ri+aoFGun8TgFOrK280/rR8fMLFYUlhcpytgDo0dD8mC8Sd
 uI3N6rm5sT2LRmPApF5cOM0uwG702gWjfVm91Kyg4R7M5YF+fgIYcOhu6K6PGOvlTRpAzeDaWJ0
 mhRrtUa/kVccCjei/eqZOnAsycNyYRy45IDseqTtQesw9jUij3YFhUzrDI2d22cKT9P2AwyFY24
 rZhekQ6h6bdoFwXs6fxlUP1hK3JM/xEaXYT2Y6e8p781399Guj3nQqItJ4bm9r+P9pE1TGCY9di
 5BMbm6xsZKzx4xuf8aJobz80ecSpa5IplzlE0SHy+3sSEOKvY4+KXNqUpSMW39QJ/hpBJAuFqgC
 BIAz1zBsEFqiYnPLZznPYqET9mB3mdrq6tblG54J+1Ft/gCKUSC3lkrOHsYgUTIPhICQsFMZKth
 fsrMxPIDqc7RxtJF+ahdtIgxAfG9/0VqotKuiFsk7roN4oBypSRb0IzDRCnV2QPAaPZEvqu1N7m
 QHAuGGWoiAklCwnjnLAFgoAy8MHc/4q0uyY/9Ke87DTIu7YUS1JoeGht/mIb2QPoko4/RY9UOA+
 LLsBMIq/B0ne+chzFQ7uikm2Iy2pTnO5yjv0R9npy8Pc9+E/y9s1WnuYE1P3t6cMvboxW7RUShj
 mmjTHW7+AzQKYydvfoRJ9KKYXxL/yuFDPTF0U=
X-Received: by 2002:a2e:be9a:0:b0:3a9:8775:5f11 with SMTP id
 38308e7fff4ca-3ac908e3479mr7253281fa.4.1793112824020; Tue, 27 Oct 2026
 07:53:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026201046.400670-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjJ_TuNMTJwmCm_KRCzbhVTKF3LprtK3RpwC1VJNQ6Q+9w@mail.gmail.com>
 <62de2755-54f5-419d-a570-d293e9a03d7c@mailbox.org>
In-Reply-To: <62de2755-54f5-419d-a570-d293e9a03d7c@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Oct 2026 16:53:05 +0200
X-Gm-Features: AclHuK93uDxG0YFfnW5vjWGzNw5UMqMBguLC04GUkaRqm1zUgpmgfKvrWcVda78
Message-ID: <CAC_iWjLEUY6k-xnKCqejExpTTL_SO-KDn6Q+ivEEMAqAS-7X6g@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Do not warn about TEE_ERROR_NOT_IMPLEMENTED
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jens Wiklander <jenswi@kernel.org>, 
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 14:55, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 10/27/26 12:49 PM, Ilias Apalodimas wrote:
>
> Hello Ilias,
>
> > On Mon, 26 Oct 2026 at 22:10, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> If the RPMB is not implemented, then do not warn about it.
> >> This occurs with older OP-TEE OS 3.x :
> >
> > I don't really ming getting this in, but is there no value in
> > TEE_ERROR_NOT_IMPLEMENTED?
> > IOW maybe we should move it to a dev_dbg?
>
> What kind of value ? If TEE_ERROR_NOT_IMPLEMENTED is reported, the
> dev_dbg() in the else branch will trigger, will it not ?

Ah true, I only looked at the patch +- and ignored the context

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> > Cheers
> > /Ilias
> >>
> >> => mmc dev 0
> >> optee optee: Enumeration command 0x2 failed: 0xffff0009
> >> switch to partitions #0, OK
> >> mmc0(part 0) is current device
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> >> Cc: Jens Wiklander <jenswi@kernel.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: u-boot@lists.u-boot-project.org
> >> ---
> >>   drivers/tee/optee/core.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> >> index a47c76811cd..9b18310776d 100644
> >> --- a/drivers/tee/optee/core.c
> >> +++ b/drivers/tee/optee/core.c
> >> @@ -112,7 +112,8 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
> >>
> >>          ret = tee_invoke_func(dev, &arg, 1, &param);
> >>          if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
> >> -               if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
> >> +               if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE &&
> >> +                   arg.ret != TEE_ERROR_NOT_IMPLEMENTED)
> >>                          dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
> >>                  else
> >>                          dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
> >> --
> >> 2.53.0
> >>
>
>
> --
> Best regards,
> Marek Vasut
