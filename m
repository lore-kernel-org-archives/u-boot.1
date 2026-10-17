Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC33CCF2CC
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 22:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B49AB4082D;
	Sat, 17 Oct 2026 22:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1bGh6CKm840; Sat, 17 Oct 2026 22:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 033A74080E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792274641;
	b=LyhsRevz9VWq/9hQiE0qMJNw6qd+1Uee+U+2XXFJp0Tar3I4N3m2lHA9UXOFkDZJtwj6
	 dFL+MkxwRy2uTyoEvchXxnyf14yNL4wyGes4l66k0BjTqjH63qVtfxl2MXqXah6shar/z
	 XUlYDE0sZT24tlBmnCAS3AcuFmGudwnYY/WSBpy1b2nbZhxz408CAwEnfTqwkrbwfPzbr
	 H8P7mX8bmEOfqXnQ0Am5J1LjC1byBHIXgXGK+Kv+Ia5ltdmVhlAcJwRAxFPa6UErxsYHN
	 IGcUiOeYcnZy3izjTlFe7fqiqPhx9GmjnjrX7nv8YiU+Hep5U6IQ4c0cmrEAIEfscsA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792274641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bYBS6zK8HJusPZnMB69sfD/vSTZQKcXZAyEjQrK7mzo=;
	b=UxmrXCshzfPMZXMIVQqgjNnbxe9IZgZHvLolVbWc60mJVSLWWsXYb1wlDi10YeBl8nNg
	 q4H/AOArIYxqGxetA9VOvR1yIEadwZjJlF8Qei1uWXzwSNRP7oxC/FqWcD6LBQEQNvVuz
	 3Y73RWafbByiKJWehtK5txKKS4YGJYXuz4ulGVRk669D2/UmDbRESLNrn5AJ9C21DO0Aa
	 NbrEi/OzSoGFWa5KBTY81kszbwnxjZbhm4xXClziLbsUncNnTmfs2mS7I13Xkx6g8RGcr
	 EqEVR0yfKkiJIL9Sw9Mcr4CpcvGgFDZ8/c2wFsbZVVNzT29L/RCOYsHTXiFCvXhs+nQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792274641;
	bh=bYBS6zK8HJusPZnMB69sfD/vSTZQKcXZAyEjQrK7mzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m3TDroB514gwRjBhurriWB0Gc/iioGVwIWe7EHYAk/gkhzCaC9q9RZ1nroWNlEZpW
	 bOTkxz/vR8p3dX0bqwcpBpm8rFaDofsHUknL+SOdSb/1jhT7GzVAYbDvYqxz7c4otQ
	 nZKstFMNRDg5qtl7tgXwQdDpTQxPhxmySn7CjuZbctEF+DZ/tgvZqeWjcM+bNlYiEN
	 J9U1RBuHfqSa1OHZkapC+OO5wV3K2nx5QZDdZShRcECeRdxbHjOWmpgsBfSJ+i1Xz/
	 M5BPrsLWmpDgYgcwWQBkH/MVUBRynVUZ52XHij3GuJ4cJRr+mphwiqBQaqvswB8dgp
	 xic2+pGlyvn/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 033A74080E;
	Sat, 17 Oct 2026 22:04:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4263C1AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 22:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2837D80DD0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 22:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id grT6w4NvMuqz for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 22:03:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A816E80D39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792274638;
 b=aXxp3gua+t2snsDcFRt5o0kpIJV6WHn8xHamY9NumCH3uu+kEaZuXqGKQLTQBn9OEb+b
 rzZbU55So4xCwrR+FfdVW6PA0IZgnaSM+qzKG1tbi5S5AHgj5wjjoSTOVAS67ndjPgmAv
 D9E8x03DmqLyEu7jQlYyrWCRHpPaxXC9Gk0bQDaeMNDQfxQ80sX4NwjcYxBEa12qNV0ZE
 20TSGIJ3B92G6Mb/NQBDJWezMS17zf2WRNml2/PQsmy2vvKKZ/+HHYmYo63nCXk2Hf2fu
 ttrnm6d6EfD+Wq8lVXKSVRktgXVaaEqJpT1JfSC2TPb51YLBWiKHDXt0TbOZHnMMdAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792274638;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=bYBS6zK8HJusPZnMB69sfD/vSTZQKcXZAyEjQrK7mzo=;
 b=kl7N44LD2GYxxoiNCbDfOVaA0NU6I3oGZECZBIbFxn19YwaqIhSCj7TJ6EkDsBze3Q30
 Lkq0rp9HsK2ilKV1SCdHjuejfhf/jbO4VYnjFVLAJqIoJ5qOeE+DgjP/5xLLXQKlIVEcS
 S/oU2JxYlkv4EgwrMudnMHGFtwjkF9mkTprNKNoWo1OUucsiaYn9DTOAjXZCfrZqKnfk1
 YXrJS3yh2bpWPmZtI/L39uZ0hII3O/bZt42QK7oslstwtMu96bFwqNlUBG1KRnvVe2CGd
 7Rsew6pT2EJG9q4Afx8u6258mlcU+ybJyDXEbT7lcdSum5aA3zTJzmPuwU5o2HvlXuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=TADTYuPb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=TADTYuPb
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A816E80D39
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 22:03:57 +0000 (UTC)
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6756a01fa01so908839d50.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 15:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792274636; cv=none;
 d=google.com; s=arc-20260327;
 b=RtZVv2QNHkEgPMwpyW2auWEcT0Ze0SjZSKDxp8VF/y6WSW3YLIxZ9/LXgJaldBKY15
 qdTSieEGqEea+Fv1fesHQU4Z44xt/68mqm9KWsR7P4Q12PdR61EPGrstvuOR00kHBsDY
 rj4PjvieV1kQVUb+NhYr/usRd8i0SkptCG72WlTrgPc7ykCp/nb8mUo3BsJYq5NWBB7C
 +fvB+nUeV82PNpdEGSDvcrZsarKyTHp2ewdI17OcF+yTNcAYEWl214DgCyvBy0wmF2yZ
 G3bcXWiKG4ZVCxxhM0++zawlZLgnEslgPElD0OxJPK2CknsJ+FeywbKAuZSggCS47Jhg
 JcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bYBS6zK8HJusPZnMB69sfD/vSTZQKcXZAyEjQrK7mzo=;
 fh=oIMmC8iu+RpL9QS0aPIrVHvb7dY/DmDKYgM4/PZle3M=;
 b=TCVqKWWyQYhcEe9WeF9MwPBXW6gdJVj9WnQtTR0hVfgpW1spyGJLi/GLUWZ/V9JTgT
 5yOGAlBM5due5BVmfNafQ6jXzcIgSSAQ2+FHm4GXMOgJ//5KqT8VXUILxi3jivSWC09s
 ZPic4KwlKbweJbPJjVXiWdwFtXn3Bn5btp+L1dMa0kVrm1cHoL3lGiOuCxxKIIN48KFX
 g3U2ENZTN06Z379yy2A8PkETD4hMRZWfhdoSCpFkZ4vW6hAJgTDQzPgUAZG6sfhAaj6P
 gB921kRrbeDOONznjbND+MI0OCpx/kYsHy4gZdEOW3ohFyBAA11fqG+ZsEATWsvdQ7xn
 pNug==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792274636; x=1792879436;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bYBS6zK8HJusPZnMB69sfD/vSTZQKcXZAyEjQrK7mzo=;
 b=TADTYuPbre/Y4tSX6fM21jEeO4Sx8mQYdDtJxjAU+r+5n3RLoLRPivzfZDutPSwdPb
 KWi2pEqS+CUuueKO8vyBroBFp2bS9Vin5XL4L9pogwG1ZWqkOVsGXtFNisUwTfUWQNwS
 ceulpWDdhUOaErb2vMrLc9VY2PDdEszIJFDEhQogp4iFW+/AWsDpJ17P69BWr3/mLKmA
 iYZjMklCjrtYLF2qUt2uN0xCZRtQZ0si87kFpEP20MdLHalIpCk5eBCq1A739TBO38nD
 XmAi7FS02noO8so3oGLREkheKItEqOxqgz971aCEcWcVZ/lVG01NntOwOqalqHGvGWXG
 Mu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792274636; x=1792879436;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bYBS6zK8HJusPZnMB69sfD/vSTZQKcXZAyEjQrK7mzo=;
 b=HGY8K6zZ/lFlJf+/cjWCW8z/sEmFK3/GS2EkpnuG+DL7fIDkHKTV1FD3AhGULecJ6E
 VMklAaoI/2aWZYqWfAtAC2Hsi6XwuHV5AOxnIiJsAQu5gXcaHakKy2BWblVC94yhB7gK
 m7+GuA7dqCtUKuiVwff9YFFLbPLEISCkzhC0BnOAZ2jKrEMnzb54SocXQ7fG/0KIFV33
 FFFGxgHdtdXbQjr+KMwbYy74rKB0Zq0jgtXeNhjGJ3Jdh8ASTUvWLPk10LTv5kkEkK7e
 gTcJeZQ+RNITkZ6sBWYiiZGI1rRCZZNDT6h7j6UOTGi0L8KjEO7rAR7YDXUTGOm1i6Cv
 mcZg==
X-Gm-Message-State: AFq9FYKZQnCjmGIrt2TzuGCUHdifRtyFT7Ce9rVdlRia0TARRoel3IX+
 SPuOL4w0psORAf0KTp1ill8jmi0yREszvl86CV58BbzWAUkPTluvKwz399crRM02gr6mKe8kUh4
 nR42BAdJfmHnvIMKFcJf+JBloMHuKitY6Xp5zy17acw==
X-Gm-Gg: AYBFou3aHstlez3zWbW0gzBa7CzESKUP7YGBxypLuKdEmQfoZBEJOAEf3oiAwPZCagW
 C0difHc7yJ9zkC7hsUVzPnD66waCrxjI//HU8yaBGimqxcQ4qXxYnsjPTr0mHZUfRUbl9Y8s+zB
 jkdyO2lrClJ8fV8pptBNGFpjTU9WqzPZ1E2sXwkD4l/3ofVlMM5OGckgGa9svplCY6FREiaE//W
 5AHC3npjUfxZlTIO9YeLtUSrmFm1IjKT9HUqLQ9Ak0iWgd9ZtZtxyluGKvy6epS0w4yHyjzC1VE
 UiDTGNXD/BRKJEXu2TL0NreShpKdRhiDFxG18UL5xniYp3UALjMpolh+c0OXnJj7ta8l1mB80nN
 rFApbfLf66wiPF/A6NIR87FAsIFtgWQk0upz9PGFop26H
X-Received: by 2002:a05:690e:b82:b0:66e:3d39:8f6d with SMTP id
 956f58d0204a3-679ca702592mr940798d50.34.1792274636048; Sat, 17 Oct 2026
 15:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
 <20261003-aspeed_vbios_fixes-v2-5-f8e593f024ab@oss.tenstorrent.com>
 <CAFLszTg=sjS0hHdh9peMk-bzbHssVpMFPDyTu694-nf3W7p8HQ@mail.gmail.com>
 <CAEev2e-CYqKF75DtQj6A9qXpTGxSyJJUbLRieyxaX6YDWOaf7A@mail.gmail.com>
 <CAFLszThAHMM_RjT_mW+3cG0oHfyO88+KOGeynOoJJ+H=DRN5Ug@mail.gmail.com>
In-Reply-To: <CAFLszThAHMM_RjT_mW+3cG0oHfyO88+KOGeynOoJJ+H=DRN5Ug@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 17 Oct 2026 17:03:45 -0500
X-Gm-Features: AclHuK_Qu4Wk5ysfbD771EVCnDPvnC0DBrhkq5xuInZsGM1ZnM7P04Dw9xj1X-w
Message-ID: <CAEev2e8gCAdRa6-EDE9HMBmue1fOxX6DiPRsQP=9vfVruQXisQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] bios_emulator: extend VGA I/O ports to include
 ports 0x3B4-0x3DA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Fri, Oct 16, 2026 at 5:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Anirudh,
>
> On , Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com> wrote:
>
> > Let me propose a different solution here: What if I just drop this and
> > the previous commit (support 16-bit reads on VGA port)?
>
> >
> > If I implement custom ops in the Aspeed VGA driver for all
> > BE_(in|out)(b|w|l) calls, then I don't need to touch this function at
> > all. All the port/range checking needed can be handled in these ops
> > that biosemu will call. The existing biosemu code will just look for
> > the custom ops in the driver and fallback to the existing generic
> > version.
>
> Either approach is fine with me. One thing to bear in mind: ports
> 0x3B4/0x3B5/0x3BA and 16-bit CRTC accesses are not Aspeed-specific,
> they are standard VGA behaviour that any VBIOS may rely on, so fixing
> them in the generic emulator benefits every future user. If you prefer
> the ops route, please add the hook mechanism itself as a generic
> biosemu feature (not Aspeed-only) and keep only the truly
> board-specific quirks in the driver. Otherwise the next VBIOS we meet
> will hit the same gap.

I'll keep these changes in then.

>
> I'm ok with whichever you choose, as long as the generic path still
> works for non-Aspeed callers.
>
> Regards,
> Simon
