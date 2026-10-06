Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53B5CA5FF0
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 07:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2083A809B7;
	Tue,  6 Oct 2026 07:09:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NzRBlNLvKqqq; Tue,  6 Oct 2026 07:09:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6ECF580883
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791270570;
	b=YTRd9jMMZhbWgkPaRkP5jRoODBGGAd8Yg+nrJqNkgWXkKZHOw1+HUEbJwBs5j6cQuN3B
	 J3f/VaBEjuhsrXbZrpNQ2gWEquT1Uo5NdKbrYP98vH2b7hNg5Jrg2xQNaqLIV6ma0iLC0
	 VmTpEf9Us2MS/grMAKhmx77nPZqSqw++1qhfUwekGIdRE227KVfiXLO3wq9qmtbEwsOCb
	 DsjKnv4QnA9t7gFIa2FeFV7FFOlZ9S7zpz65cl7U7wvLXrLTXZkbqtOlZhyFUpA5fLU0Z
	 9DhseQLvML3l0l5Eli6kHY01DyDzsIs8VD6qObN5BgPM00/sDp1uMdqHS/mqRFceXow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791270570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=z8vzqw69u4Ks6SzsQzlZBaeqqj5JVhi9cFht4udqKXk=;
	b=JungsHBOchiBC2CgeVLJWDvJ7buGwMsI3WjCB0IWBPxsZ/pp5fP/avguLbxGjyZq0XbZ
	 Fw+FMUfZQ/6NkBMe1pRwWd7JY9/e+6R4UXUM+xioizxvYML7VQXwpFA3exWuJ8sw10+R5
	 8AbPzeVvDsnZKcuQUz2LJzpLvEHFsE8uZ3HDxzo67z6DitXikis4UfGSjTOXHHqMuGmed
	 ExJh+GZY8i/aeKk7+FLQtf4Gufo9o4IXssv6GBt8mTwDZAOZPChDET8iVbiNK9XLzVGYr
	 0acfCw1lkQXQFuqy8nWFYvfMCstPYCwfDd1XAw7RpVHIoRJHVY1rU0IsaEITkE5YvPA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ol5bGQEv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791270570;
	bh=z8vzqw69u4Ks6SzsQzlZBaeqqj5JVhi9cFht4udqKXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxbwZZpTiGiCootCWg6Y0t6sKjRQ99NH+I1CCRhJx54vjqA7rmN9wls9/HFw0lVbX
	 ZtKBs+nGWDpQ7llzAW1MdHVg6b9LUjHiMsEsivB4hX5bMIXFrsgUD5aKjbElQz0mI0
	 RSfedc5Vx733n7V9g/HcPpKfOODkNGCORs4wO2pEFUc+aCwgeZAxoBLW5tSwdunBg7
	 TUJmENW+44onACji8ZF/xqQhf/8pfnH9abymxuHQcB6QhjM6tJWluQz33IDaobK2g8
	 PSp9YJ3NI3xyB0mPK/mRALElQbTrv3HvCS6fAK2LhdDY10/+z3YWDMoYzLx49T/dKj
	 XT61m4gGyj94w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6ECF580883;
	Tue,  6 Oct 2026 07:09:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E9D11D2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 06:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1002680980
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 06:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-iJtvxiO-Ed for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 06:56:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BCD9780987
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791269800;
 b=oMdA0I+/Y6nfsvhi0oMNZAvbLo1E3rVzfe4LobN8IzA24dAzRvysn2KpXrn6zLl/yONB
 ia9wXl6Gt3spNb247EjJ6ymD6mRXDN7V7NyKn6Iy4QSdZI0zhHJ9TpnKCUUHfQjycHr8l
 Ho8zn24EeWVfIgqlJDKQpNZxefKAkc95mkh0hto6J8vYcup9c3AWH36hCla/sN8bgFjkL
 LFmFhiC1sWf6EeXYJZSq6wAG63Z2SwEwZ4k4ORmMqLoczUVTHU0ZYKd2qKiCXKdGtjIh7
 4ia9Pls/+eRYO+cuNhOpe9CAy7WW8e/agOYSyvlYpWA6KSwkRpRdLSGQcooxVxUwiBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791269800;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=z8vzqw69u4Ks6SzsQzlZBaeqqj5JVhi9cFht4udqKXk=;
 b=H6Bx59be5KvSDX8U5JrgdpAXFLBKAZYVMmcf+v8JeNloCXRKwAFbe50mhu7A49tbccVv
 ga/pB+rHVrHLvwYkWLxlvS0524489e8pGtrzsTrlBeBsUJOPU3ITas+1LhDuxzYTv+in6
 /wKslTMRbsAMZZIyp4P0y50y7wgPM89L6VNU1nMv/E0xRSUYcp/q3O47zILpJNU9R5HEE
 2tonD/PDO3fk0UWq1PlMn1gw26e+dj1ityvQUcxHkdSwCD0wRgzI7ixEZdzrRDnXWVF1m
 mojgKwLtvsgBLEsZdJLxo0ByEGlN1VYYe5Wev2MX0YTPEIIh69bsedki1BzYhMUe9zA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ol5bGQEv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ol5bGQEv
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCD9780987
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 06:56:39 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ad549a2119so2664317b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 23:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791269798; cv=none;
 d=google.com; s=arc-20260327;
 b=QcG4n1tOwDwxOwVULH+uddtGeOF9JNsbQS2uHelM9D9iR4yGPnPLBdk9vatzYUsBgm
 UA980S6qdmAyiFOBnTsdl2L4pk/1rlkcU2lUWcl+nMX4snXpsPhe08Gpj2UbEJi/pxDA
 RiIyr9CdOLAVoLvVvyh6XHlnFE8MQJSuViuiiVokAcDOdFD8frscDG0kjwEBtjP5dl8I
 e4bIPgrtRo4nMNgT3CJY0F0Udz+qEiTsqfm91bVIZhHUgZDvAURbYaCo8G6/CDB37Y+q
 ZzB7xUD3icCFAS2TROnC19t4s+W/i0kX+j/n897TF8hzRk5uf2/1ztDFbiekOcTlVE+3
 3STA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z8vzqw69u4Ks6SzsQzlZBaeqqj5JVhi9cFht4udqKXk=;
 fh=9EQQAllexISURy7RBWaEtMCW9dJPeQy6Oq6mMhSC0aY=;
 b=ZHntQ8gytztvWKkwkev/D3HuKUVuHmkPWml3oE9IaMTycc3BKa0KIJTDZY1GbTfXSm
 3vFofs1CkfqUs3wU1eQSPmqTxjeKx6dX3RCcvxp6Iy3FWnANSYkbkKmDTEl8All0Il+e
 i3R1VzQRaGuekU3tCsBphowR79DD+antHXOgpvvDG07htTrwfTKvTIjlGBV62YKc0/zb
 23DPbxe75uyL9+DHVeDh1c7wGw97vtdQrzsmlBRszWVNuEZGL/3MJIxFmncgPPXCh2zF
 lh4sghU1jXDPNqy52euJ4iw+3rmH6FzcQJKGFYA7dOcxxJeCst84MrryA8LGq2Lcz29Q
 iHkQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791269798; x=1791874598;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z8vzqw69u4Ks6SzsQzlZBaeqqj5JVhi9cFht4udqKXk=;
 b=ol5bGQEv5rm3rvHv+WOxMHNLvMh8v/jPQUFB/eawXDGr+8OmVb8vRPVWcPcyTc9Doj
 M3J16zJug35nB9zmEVto/o+SskhxuNz6qgbtnzVgweHAnw4jW/X/VXGpNQSmGT91hv1A
 RIVxnSJRFj7tjwALEJGk5QHu2T7YzfSrH3D9f+yENhAYQpC4q1Z3t+eK28g1vz0T2/mn
 x54ImXar+yRPFQQyx49erook4pOn2FBAHztzT5k3smszXcG9rRCR7hfSISJLvOciT9de
 RtclBI7497SWT1hKmcl1ibeVEozU53If6KdktkJBkVVftxtvPJTIET7u5bxxIyQyiI0b
 66Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791269798; x=1791874598;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z8vzqw69u4Ks6SzsQzlZBaeqqj5JVhi9cFht4udqKXk=;
 b=dhtE84qyn3UceJtoa0/7WOUZOkD+VLyRm/flRojVoj+wIB55bLis7+Zz2u3jfetBbA
 EVuf2CWJ6TY89B0QY2NaHaNTFf6Ithn2QvhOtNRVfZywf6RF7lT8brsAWF70iz2KK0vd
 zSudhFDA1gHKVPR+HWtMnoBiuyb+mXvnp8SFaH+kBnjvtpk+GfKiOAWVYbWXJ8D3kB19
 2dKtrkru14bOqKfQFUAY9qSwHl4Ir5rs3ByROppdw9kjGaCeNGKcmYNSEmpY7yXaHGam
 7OOEs3Fd0kBXyhjAFqUfLkLAlFIywTSJeLyuZDAOzMaA9CCrNlXQBOlAfRJZxEhp+oQV
 spEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxSanDV0h6hHSCOfQN4ASTR68JouA28eG9vP8pP64OP0S2nqPHAaVCHkpFuyVDZBjs5g44pYQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLAKChzbqiOUqUcKcjQZostiQHaTZGxzJpmUvRgnsBIPvJExljp
 pd8koS3fcJbBG+SbjVlxBy3EmUp+CAAofEZi5ARjIpY8AJ40aV3s7pe1tUM3byNyPQjXzYxDWKS
 W+GQZ1+3rQBk1Tqefda5qTTvjaPLibsLUm0p4LHdvzg==
X-Gm-Gg: AYBFou1uGh9qYJBV0pzgQAv8bVZIFTRkPxqQaEQROORl3NsUmD/G8dCEBWb7O5Ok9oF
 N0Ae//lF/q4WaKagT/amkxilCK9dc1d8+Yamk4fUiXtY2AyEsuNeriPUfJeEfC2Abzow8xZU1eH
 nfQ5BrIP79+OWhlVl0DWU3GiF0tTtTT3akdowK3rz3DpkB162zRKWmNEo6yg+965akug3uU7lCd
 m+G3RU7dRA4nz9JQNEogNfEnUQTAZ1LNdUcJ9fcnqTayvUH3QwUQ13EtEtc65nIyPZWPSFHRAEa
 HJVsg1DCCIVXCRTvL9oxt0Qwd1/aVymRaE7GyaLcGnCpxgMqBev4PBNnyN/0x4eMobzsHuC6q5p
 NZerj3DnjdWgfp61MYblZQ9+J3CnBlYtUqthvYwZLwJxVz9g+JI9kZRY2db89PAutchfZH/7uiq
 gP1STNVif8/SvNRhnCfqtcDOd6TT2L0JbNg1IPYGmHFDPbTC07hYXa87Mt9EiuRR3sP/qI2nHiZ
 nRRlzkEZhVQDWPjOEXGObqX6AW+BDIW8/wPa7yhIw6k6fvR3WAGywE8DzPu0eTOJF+ufy2hmQaJ
 svVkHzPsh/nVbidwgckYwLob9oLFcoAElSMn9OzgV8dJoXwDBVEv8bP8XuGln2wkONDjKMsxgLI
 cUnG8zyRFmnEXDnmv/F7u2fC+wEkFriVMB36A4GNWVHOU0Mbq+2A/VQ==
X-Received: by 2002:a05:690c:6b12:b0:8ae:a5b5:e97a with SMTP id
 00721157ae682-8b04f397370mr1643797b3.13.1791269797851; Mon, 05 Oct 2026
 23:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjKvJPtNvoMdcaw+jg+-9=DNOpSs5Przkie9kwvyE=u99Q@mail.gmail.com>
 <20261005213516.230662-1-michael.haener@siemens.com>
In-Reply-To: <20261005213516.230662-1-michael.haener@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 6 Oct 2026 09:56:01 +0300
X-Gm-Features: AclHuK8LATMYPSMWsoO9ncyHwaMrAMHFbmqX9B5hAKQhrqdPO97wRbQlE5ALwX8
Message-ID: <CAC_iWjLUyW4CQGXkjFimGLPhE27Dp+mDObZtyvn0K3rME4aEQg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
To: Michael Haener <michael.haener@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, 6 Oct 2026 at 00:35, Michael Haener <michael.haener@siemens.com> wrote:
>
> Hi Ilias,
>
> On Mon, 5 Oct 2026 at 12:08, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > Yeah, I'm not particularly glued on "let's make it on probe" either. I
> > am fine with the event as well. I just need a proper justification for
> > it, because initializing it during probe seems much simpler.
>
> I looked at what the probe variant would need:
>
> 1. Nothing probes the TPM on a plain booti/bootm, so post_probe() alone
>    does not help. The uclass would also need DM_FLAG_PROBE_AFTER_BIND.
>
> 2. dm_autoprobe() runs in SPL and before and after relocation. With a
>    bootph-* tagged TPM node (e.g. chromebook_coral) the self-test would
>    run in each phase unless extra conditions are added, whereas the
>    event runs exactly once.
>
> 3. The event is purely additive. With the option disabled nothing
>    changes, and the uclass, the existing callers (tpm command,
>    efi_tcg2, tpm_tcg2) and the tests stay as they are.
>
> Having looked at both, I would personally prefer to keep the event
> version.

Fair enough, I guess you'll send a new version incorporating Simon's comments?

Thanks
/Ilias
>
> Regards,
> Michael
