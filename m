Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFA7CA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAEC4607EB;
	Tue,  6 Oct 2026 21:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQZpTvrqE4Pm; Tue,  6 Oct 2026 21:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 98ECD607CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791322396;
	b=Iow36o+5E7cDfrdHTmDmeoOHRqrwe3HTx73/T1DgkQOZkUtM1R9sS2FxZ+MJuGORvbPf
	 hbM0EH4Ok/v3MiFsa9Ezoy0Wi8zf++wYuhtVgkodQBCwbtI1RBHlE6T5gV954dYiauuje
	 KGbWcY9qxVEn+h8EODBOXx66jFtGnZidri+LrKSaiMuqbdTLjxwWpZtpfZDxKCfzuFoox
	 5ntgBIIjGmLqwUrI4aZIOm/QTAk77oAPEz/ibG9bYb4BOO5tUJ6aV8Q6Si+E1T2rMKhkN
	 0S+dJQAy3DLgiLCTih48yFC2T3dRzL9lSx8kN7WPGyf6wFFCPtfeWk/0PgHqcyhuMdw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791322396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QBAm7VbgOc/MKXDa6q8VnlbubISsFUZRAshXcwctIto=;
	b=TWTdieDLciYoE+FN+gsRRhmgkzAbERgQ0Jdab6GeBcVezEMcKfZuMf4vxCwrS5T1we1L
	 CD+qJy6q4u1OEMwD1C3onNx0rx0k7YawLsbi3IE3X+7QpakLbH8HOPpVIcSMqSe2f60Xf
	 EwMxBu6sUUubqw4a6JcBi8ThqXEfS0FFYzCsJf0LBXkztpjTa28lmPoWezfyxe/3zve+7
	 3s3bEkgmaVr+picR4vn+6S0PUnDY8LFO2sRp/vb3B5kUQ4KC6KjIaFEuzQ3IfgtS1Zw1i
	 XEnnyEXx8i0sbPTq/mqq3c0c/K24h4HP88SwBr9wI0Od/zJNrDOAKSoF4tV9AENhmhg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791322396;
	bh=QBAm7VbgOc/MKXDa6q8VnlbubISsFUZRAshXcwctIto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=siIbz1euNUv2BwqUBPYpnD+99v76hPZN4vEvY+UwYQ8beCOuLHWUsVQHyVIDbVf9K
	 x5qtfg0P8dUghoGmkWevvRtIh04QHwRia3MxG3j4jFUnrM1qHDIhT91y5mvQ8hM0Y/
	 YwguMIMs01o107IzDUlBKIcmnx8MXJ3vjbP3SINZc6loXlcQiAs2KsTSHOKKx+kJRG
	 LlOjnHEXQcnwkensoBgKA6SzGZfdRbtSCXONNbWvUzVmB+ZygGdiuIZFHHge/4iZop
	 d0xUNCDd2P6oh24B5xcuAocXLYHy7TtAsFA/xXe9vQtlNpYLy31vrc8wQ4/pGnvoRd
	 Btk4p1ckSt20w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98ECD607CC;
	Tue,  6 Oct 2026 21:33:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 397851D2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 19:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3671F80EC2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 19:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K50HDpuvszRz for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 19:18:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2906980EA8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791314323;
 b=Kf52KKlycYEw37f8SzQfJ+EakPJHUiSpQ+s9GCVaAkNMziy6vrhCboZU5o1oH13G6k7T
 WniRD3PgvW58XShyWi2BbAulNt4v7S4QH+iukekwcn6/Fi8bjVr7F9M7BuZef+TTFltp+
 Dwx97X8eSNtAeKVi6DRTrw/wkaAi24nU07FWd/lwoxKDeGYVj9Wzd8v0tcFAHvoeF2+aH
 G6Mt0tszWyxOBhedPk/UbwttxP+n6a0mNID62jfIp9b+mlnXEjelLnZpv4lOYrpMU0iFB
 rpMt5BEfKdIyvFh2XRQqSxf5P3BUkkaaeUfoqbxgwMAcZ1L/6pE7d+QUbt/i7XmGxTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791314323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=QBAm7VbgOc/MKXDa6q8VnlbubISsFUZRAshXcwctIto=;
 b=Ujsip4r3xfpAZpmzXjUGzvFZC8e7Swiy5P2WzEbJY4UmcwjnWLP+em0JQQmtwkelIJV1
 5JhGLZs7j84vZMw1OA8NwGDpVsv+IfKy2OnUJoVu6cRCus2EI4VLlk9uCNZOi58sD+J5/
 e7ps8SPCmIHMG7jCfsag0Ui1FjpAPuiqM4LyQC9YdZ2dZm/CH38OTS+2wHZPp10PEBKIQ
 /jMZtJ7NIbbgL/imRNUJNueYX0WECYGLn9LUL7kJFSkvR2mPdIZ4ZWzuTfmhQPz/4fwGC
 8gJJEcCmjLM3iMs3RsrgqEUVy7Sbn6B9HAbM8Bf6YAMa0jTkdx51o9Lg7aSgsRb4HEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DKSpCitb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DKSpCitb
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2906980EA8
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 19:18:42 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6d68de53053so419446eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 12:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791314321; cv=none;
 d=google.com; s=arc-20260327;
 b=Tlp9PUnar+uBrOR2P12k6iKgJ9tQrlYS02zaF5tGq3xqmWBeyTwEGmchvT9rVY7W2U
 MKWifptVsg8rAqjixe8Qtkbqpbj/r/UYlbu6+R5nWauK4t/pEQ7KF//zpJjXXLX/5Njc
 4nBa96OKxEl3t/GmgW9JB/KyW4FXWZuRpKqNxQKXsMGScmb0zpqkUf1qiXqpikdLciz4
 LLV0Uksas9LFgPe8TSF2EndiekpJvnX/X3jQO/Wf0ZmdfZycHorpSRB4tjOQnoTjeYxt
 WHTtaDgtBAJUszZOfKzBr9dTqO2iTlJuEfaA8RUdcM8iTc7RJP8ZpjJ3/vE1pvkJkYAy
 pWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QBAm7VbgOc/MKXDa6q8VnlbubISsFUZRAshXcwctIto=;
 fh=Nm4BIjkM2rVfJFEYMaDdrYgmi5OhdT+gZpFq0uVF61k=;
 b=FCqYWTFlT3KCYo/an5r4tM9vQ4xKkr52qWsDEiwL9XinJD68929YIW6K/qdWY2ydM+
 eQuS4U7Bih0+vBJO7XE7XUqw9f2a5xtNDn5B0jLyK+PsBt2p4Y0XHEwM14tpIT3A/EVc
 +DHzDcD6EMGukMS8dbhxXbN3wck/jw45O12dqxHECt/qGjLUzLBGIGlmOe6BC4YHz3of
 YHQnPZxr4tlfmBbwlFTsMRz+E7mtF1SqjH3gNNUAyMQDG0HfrwOUkIj3s/THiu+X+MZM
 RE3piF+sP2v7/ALgf7CswtgOCOj1TLTUcEP66ZyuTsqiPRUMDkJ9kZ9yLckmF2sI6iqb
 3cyw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791314321; x=1791919121;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QBAm7VbgOc/MKXDa6q8VnlbubISsFUZRAshXcwctIto=;
 b=DKSpCitbKIeKqE7XzOGHsCIy9nRTIbj4gSq5f6YvS+oA5BYHFC0QUzoUSrCwdNKRel
 cpPIAJjx379wdFJe1VageuDjT4RU1nUAiT9dbJSXBxOFgVMa163hjEu6/1EC3T2PSaiC
 AQqmI41sZ25N24h9j6t8H8F1brND34qPDPQ6V1HIf4nqp1CbJasTLzsz/1L9QBHkTOeO
 +/i3qaZvj5Y87IsIESZhdyU33Qsex6igVunFx5Iy7yBD0YasTqrALrE0znRvTyek6MZE
 cGQjCR1X7A2rzzqfbMn4AvOK7tmGcoktaDklk7CmHtqPY32ZKiwUhoMBMZTIq40FcwEL
 L1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791314321; x=1791919121;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QBAm7VbgOc/MKXDa6q8VnlbubISsFUZRAshXcwctIto=;
 b=ufcykk9TuzKgrPqITg2hiOW7Hx9vD7g8lMHhv4+vc/ei29UcNuAu7p3etEdsN1VSvh
 OwLbMgxo6u2Y0yBHEc6G+jzrrfsFg0s8a2FX+YmkfxAt6oXSwrzuFR+IYaWkTEYTVuEH
 RB8j2RYDu6cA13BMm+DPJlD40IPvCEJywVO07ypFy04WVbsu/m2OxI+UCUadS8AR1sgU
 0jJMx4O7AuJJAQMg4dzPx3JHAK15arGtmJm0XnYQLd0sSIvEJWV941aiSKHhlm9DDyUQ
 BIBxaEa+W71oMHIekRRdFm5LyMDHALF1drExjt96tuyqCwfG9fV+h6eSmHpcabWwkLRK
 0lYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtyP63j+2VqgMrJWuV2bzRHFdnq4BXTM91wfa+/hNB18SpMF98uKNAPFig1IFN+G7TW/r1zuc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lo8aR7FcXVRxOX6qsk9+q/NVN494iX+hrK+rfjPua+DNfFQ7T6
 d5bdHaNK0dF0gvrku0ZicmCJJw1zwVzyiU0BZs5n6pzeYokzLb+Q49MuYJtkkd4p6cy+FYZrN9u
 t0wnKfDGrHfhgCQv4NthBLDtM9l59IKpOhoXj1cEdag==
X-Gm-Gg: AYBFou2ALBfYXNajqehOQf+Vl63cDbVzqXaNmF/Z4UQEBE9ib1bpW9s+IPYhTAK35IK
 9UGYdkxzqibiQi8iCD5e/HsvLDUN+5JQ5QwF9EDeZQUyqdc/yVyVtCOwrkT2lLQRkxFXTyg2rgc
 czX/hJ2YW7V+aIj5X1mWaIKDk9Z10V0kVVjRAjeO8PRAc8CBfWaASyMwwf2G2hdDFGdklaOxPmT
 u625x1iz6quku6GTxj1XTyKxawaH1x2xFu9rB0a8G4p/PRAzvYCYK3SYtDeuocz6CKrfdbxO3R/
 txCQaH2dFF/E/Mrlw2XkCjyYLSoe9xm5MgA7sZOK6x29DPnsMTAYeHcAtYFqEDziYNCGSXa4U73
 o8xzAuMP4aDiDGA==
X-Received: by 2002:a05:6820:4ccb:b0:6b7:46e9:96f5 with SMTP id
 006d021491bc7-6e7a8ffe4aemr106058eaf.37.1791314321382; Tue, 06 Oct 2026
 12:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <e45caa4f-8ae0-4c0c-a3e9-6009b68f3400@pengutronix.de>
In-Reply-To: <e45caa4f-8ae0-4c0c-a3e9-6009b68f3400@pengutronix.de>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Tue, 6 Oct 2026 21:18:30 +0200
X-Gm-Features: AclHuK906kpuqaa-qh8rWlPvvDevroXzqJaWtvGK9-1A6p7q4lwjqsZAlCNANr4
Message-ID: <CAByghJZWJu8EY3N--t853tkKQUqTHqEDbQP2VMA7Whx_q4JvKA@mail.gmail.com>
Subject: Re: TOCTOU issues in AVB?
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 06 Oct 2026 21:31:45 +0000
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

On Mon, Oct 5, 2026 at 11:34=E2=80=AFPM Ahmad Fatoum <a.fatoum@pengutronix.=
de> wrote:
>
> Hi.
>
> I am quite ignorant about how Android Verified Boot works, but looking
> through the code in both cmd/avb.c and bootmeth_android.c, I wonder how
> this could not be susceptible to a TOCTOU attack:
>
> - do_avb_verify_part() does avb_slot_verify() and then discards what it
> verified with avb_slot_verify_data_free()
>
> - run_avb_verification() leaks AvbSlotVerifyData *out_data and doesn't
>   seem to use it anywhere
>
> So it looks like an attacker able to interpose the storage device should
> be trivially able to circumvent both of these? Am I missing something?
>
> Cheers,
> Ahmad
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
>
Hi Ahmad,

You're right, and this is a known limitation rather than a new finding.
Initially, the verification and loading steps were never designed to
share bytes (and it was a deliberate trade-off).

The gap comes from how the feature grew in two steps.

2018: avb verify was added as a shell command. It landed in the
boot-script era, where the only way to pass data between commands is
the environment. So the command exported what fits in a string, the
cmdline, returned pass or fail, and freed libavb's buffers. Boards
already had mmc read plus bootm sequences, and the command was dropped
in as a gate in front of them. The threat model was offline flash
tampering, where verify-then-reread is sound. libavb's
get_preloaded_partition op was in the tree but never implemented, since
the shell contract had no way to pass load addresses.

2024: the bootmeth basically reimplemented the same steps as was done in
the script. The commit message describes it as a rewrite of the
meson64_android.h script
and lists "run AVB" and "load boot partitions" as separate steps. The C
code mirrors that, using the sizes recorded at bootflow scan and a fresh
read into loadaddr. Copying tens of megabytes out of libavb's heap
buffers looked wasteful, and the preloaded path would have meant
restructuring to load first and verify in place.

I was planning to address that, it's on my todo list, but I haven't
found the time yet to play with this.

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
