Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE78606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WRYl0xPE;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iiJ29H+/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C118380D7F;
	Mon,  9 Nov 2026 01:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2sBm63wLMRJU; Mon,  9 Nov 2026 01:38:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB52E80DAC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794188295;
	b=tdbyrbKst5z8Jgvd5TGYeXj0AOso8oCL91viD3ptCJSGlEqhlfc7BSw58X58cMGc4zX9
	 5RKTUWemEIf7z0CkSIodK1Xt5wz46o2Qf/BV8emqzTy/m1xvDIZT6sXIrMURYk0kX8246
	 1eZa3jXlO5wmG4jQglki45EBvngeuQXx54x6fTaOeyAKdL+cPMrBhHJBEnxgvm84jSbEZ
	 gzCtFgXBzcCk+BG9TXzL1NwaBM5ZjTZIXebhzBWe4NkgbyMQUlRG5fWOGyqKADXj+qhuo
	 TKXFUUBZMl5WaykOc/CJaxF1c4df+y1ZRh169WcuONRww1C/6GtNG6mkYbMkufoAfOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794188295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=23o8go3sahW1QBbQjJVEaNw02Di9EQj+wLb+cn6VCz0=;
	b=bjEeNSI8dGBtcqWrwdxRSxlzyyk2eAOPO3nM6WLZXodqu9leCI2OvGxXZw3CSJqyPbdu
	 Sar5kXhteuPzMbcle9cfIVpNqXQe91jhCEj0fwj/dlcYa1ltj84XyXvaFJax0rO75UlZo
	 w9GxVdnszsn7H7ZSpygqjmS1wh/s4B3kyjbwNaiqcbsTmiqWUkhDRFX/NI9Ojs+uZB1fL
	 l1L2iCdObmIQvvBCZ7SHYnm3W6rwhW/mtdpBFIfX/mcKaEMVqPXZTAhph/brH6lb89iUw
	 K53S5O0CX7m01kz0m1M8KurA2HjUB7RICq73gx5wt6szmPLNCumyJw4oXxQhma/ewjQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794188295;
	bh=23o8go3sahW1QBbQjJVEaNw02Di9EQj+wLb+cn6VCz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WRYl0xPETvxznu/xpPMBLrh4gUWJAQ7o0Cr5+94Byt+MQZCNydlZClBh7V8FHNbbD
	 CkE7/hdbdvZXx+fKVLCjWpZqm8GVcJdXfPngx1qCAclxP+zyXiihMvLMsTnfBQXV4k
	 7ELevxVB2CoQ1tJGpg0pXFGYhYVc5uWD+VeYCuhXDB6bMM2uVyKaB4zHrg+80e8qLi
	 0TsasCw7vgA38NJHGF9vrfm9wbncc7wKMOwoF2hpfVtgS5w4pd2Bjy4rcWEApiegaV
	 JKGCh2ykgVZUKlDiOGGHFiLmFlPuB+ctTgHbpbV1opOVOKm2iBlcJSXEesGP/+NX3s
	 /NAQJo4zidsrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB52E80DAC;
	Mon,  9 Nov 2026 01:38:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F779932
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 01:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6CE2D6066E
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 01:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1EHOCw8frYzb for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 01:38:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 714D2605DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=iiJ29H+/
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 714D2605DF
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 01:38:12 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b31448caccso1956567b3.1
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 17:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794188291; x=1794793091;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=23o8go3sahW1QBbQjJVEaNw02Di9EQj+wLb+cn6VCz0=;
 b=iiJ29H+/nXJ492J9TC0D+1jGSIkp3pv8ZNQyilALMKYU92rw8HrU2GzPGdC1yAesGm
 ZAQu04+IIrThOFWbfs9JdLPuwhAN0rdudgxTXMIqTj/jlD7sEu99V7vPzgVpIwGazO+H
 6XUBPGnYFTSitSfImLWxJyIi5uaLFhY71nQSn8q2KhUb634o8Zrv5RLGWyKLp/UM/UG8
 o/G91nqo1haFafHpbbipuE1KiSjkF1gQ8QSHllDhLBE/4zFKPWKoG1v7H05G0BW3qWET
 Jgf3GLBf8CIl7Xk7MGg8lkmzK0952DHLDK9suT3e/RPlBfasgaWu8QC5dkNMv7FVr1tx
 DCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794188291; x=1794793091;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=23o8go3sahW1QBbQjJVEaNw02Di9EQj+wLb+cn6VCz0=;
 b=agr9T4jTOtoSS56G3z9IjEQOCU+oG2Iblj7vYKgdej746ehb4NVxcAjaOhy40pf9Bi
 8yvELvaWLpTsNCIc3FHSGFwP+h08Poa/rkou+mLJ/9ZeORhSPZcKOQHNd2JlZZolm9Ip
 +XIClvOhIIoDysYvLBpTjBuuBj5imkBDqiKit5wGMAWGTFk7IClgSpbA2lQNwBwCmP/E
 ptdZDas3cs0PpyRxs+VI2jSVQh15yp+F9dUp0QBv++NYGWf9xvuEWvpJQadPDYUzcjyb
 WwFyW7STlD1q6R8aEF+N7PABWcOndMhNKreThcDNbyvXY7eAJjg4MdacWoqbXshGWuuY
 2jGQ==
X-Gm-Message-State: APuU4Z94IMgv6+OJHtejsLXJBGseUqrdPGUP2seXyAJniITTFlUscyV/
 Ub62+DOlZDAUcT+vfz2oN+XU8C4GnWjQAKkiF0dW3g0JFmNgPL49oCKySXN3tfnWPhV2gk5GNAe
 SMenYeJoPBuhR3M5Iq0E+fnLydQ+R9CqwW+eC
X-Gm-Gg: AYBFou2hP0xwimHoZq1HbH8Y5JBbJaJb0w8KsAL/t1dEWUhVLOYCkmU8L060dK2lmyp
 ZhoLlH9ujV495nf+4caQjq60emFeBRJevMePnvVsdYvZm+ZV53ChdtltdSkHPwo2U1OX4GR3xJL
 EMWkuJNgiCFh5YGeUX2PnihGKTuk7WtfJI/QQHxxgHdpL0u6wivPwG3zsdNTGlKKbzemgD0kHlx
 pCBQ7JlUVvJZNc3lZihouuruFa3fFUI3UhtuTyLYXuhmNy/aIhvPysgnRHX21a4zB0Q98a8gMQX
 udK7za7ithDhFB/FkeS9Ulpl+XihePLG6L2Ep0ovw3O5amEvOpiJuKR9orZPwDeMjq+uBOSJzGv
 Y1v8+ZbRy+lghRybCJLO/htj1ipSIn7wpDW7nuLuXIv9YnECz3Vf0+dbww/3Euewwao46XZyOy8
 B+
X-Received: by 2002:a05:690c:22c3:b0:8b3:8d8:e985 with SMTP id
 00721157ae682-8b36cbab23amr15561347b3.57.1794188290716; Sun, 08 Nov 2026
 17:38:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAEUhbmUriwAm2_WHVDEB6mfwH57hzFYbPd-4M6nyUGFqPEHcPg@mail.gmail.com>
 <20261108161357.GJ3741582@bill-the-cat>
In-Reply-To: <20261108161357.GJ3741582@bill-the-cat>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 9 Nov 2026 09:37:59 +0800
X-Gm-Features: AclHuK8m5zomW990fAAlmq1g0Zy5XVzZomtlPbtH7RGAuz3dV-x-i1sGURakfVk
Message-ID: <CAEUhbmU-HyCr7DuQUQvz5NX3PSzvyGYoem07VnquHzpBVw9SDw@mail.gmail.com>
Subject: Re: Please pull u-boot-x86
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 12:14=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Nov 08, 2026 at 11:53:48PM +0800, Bin Meng wrote:
>
> > Hi Tom,
> >
> > Changes for this release:
> > - Read correct TSC frequency using the right cpuid leaf
> > - A small cpudid implementation refactor
> > - Display actual CPU vendor and device id when booting from coreboot
> >
> > ---
> > The following changes since commit 934995f642a21ca7f35fa9aed5f061394fcb=
a243:
> >
> >   Merge tag 'u-boot-imx-main-20261107' of
> > https://git.u-boot-project.org/u-boot/custodians/u-boot-imx
> > (2026-11-07 12:04:01 -0600)
> >
> > are available in the Git repository at:
> >
> >   https://git.u-boot-project.org/u-boot/custodians/u-boot-x86
> >
> > for you to fetch changes up to a7f22b345ab311488b7fbc242e408e97eca4e93c=
:
>
> b4 shows a mis-match between the hash here and what's in the tree, can
> you please re-generate and re-send, thanks.
>

Weird. I regenerated the pull email and it's the same. A git push says
everything is up-to-date.

Regards,
Bin
