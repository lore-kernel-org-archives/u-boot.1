Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDD4CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85709810FF;
	Thu, 15 Oct 2026 08:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OP6BdKSUGwDZ; Thu, 15 Oct 2026 08:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B01781109
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052886;
	b=tE+Soa5dzEXH1KD/GlCPNyLLcW2EHrPkwJ1RUcoSDs944YYfM8sMvMiPUoqo2kAfIIlc
	 1hcauaMP/4+KectB3WGxJvBafqkvgNabQ5rAoqwP0tERw0a6Rx0wnx31My8thKlyyzjV/
	 47N5rYiarkx/6UBcgldD7J1N860HpP/axfpvTtmP2bP5RqFOgYAe/+/h8DZxfA2t+MNWy
	 UkpleVTWQhbs19ccFEgkJ/8zssnhE8e6qeObFECl2MNEATBx9JYGrDmuXj8clNP1vVnnG
	 J1KIHmoJFeER/RAqUFpGHR9jV6luYPA/xy4buL5SIjnUxPLbColNPqi/uKyM5gTJpQg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dQnYr7jp8ixsTSe4wYDcpgrG1Rl0Yer+yf9BUjK3VTU=;
	b=OI+88j7zo0bwANaVCZ5ivoXNrCpL/VDYQnVOcihFsX1kh4lgYc1Nmoj82LG3h4pcX+Cy
	 Oo2Z/f3QQmtu0F9uPz22KoFS/QQeqgc5LmVNxFsy6FbVD3Qa1lw+hbji34cSiAgZtzPLE
	 A3FWdr455bKrmvfPZEtTVoK23JYU+yc+X2GqqKE1b8XKb3vfqHRGM16mDfXwQVYvqb9tp
	 b9Zsxiix1DaUJqE4xbNvd/EmB4WCQHF3dAn8ig/E4U7Ha9HkHaN/K53Mx1h8fVvmICV1j
	 JT90UpBMgGhqXHJ6IRpEfVcEeizYkSf4Xj6aLEmoK5U7orYAKr1ibtsDyE7cxdEYKwg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052886;
	bh=dQnYr7jp8ixsTSe4wYDcpgrG1Rl0Yer+yf9BUjK3VTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cZWJtFeY43QSkDxdJwyCIZS5mt/Z/W8/U8iB0yJLMVPqoE5or8f/8vogFQBIr3lAY
	 DB01BzjWv4laXXakvxP4Qg0CWSVSBQN/uCKAk3UVyNvsNKlPhgsFT5dYrPuf79wyAR
	 /rG+e3ADiGadvUAvklNmvEuhlyMLfQB+2+FnL02OsgMhYcMOR8LB+pewJTLfvi0XOv
	 S9cGTQFbCU+umZvHShkGKJ8G7FjiEiMiTdTCt5DcDzScFJQd7Ve6ukWXwY2fDHag1V
	 jWjGmmI9iGcBn7e7LQk0ff6ro6vovh+NDN7+yYk06/CvoC9aaTZo6RmhnRWFDMO2T9
	 pdzupZnRX/oFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B01781109;
	Thu, 15 Oct 2026 08:28:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 93A3E2A8
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A26A4037B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8tcdUNR3vTpG for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 07:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C59A840053
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.125.188.123
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792049475;
 b=Y47WAPhW/I60pc7zQTkKi3fXLlyS4W96DmdumhqdfmIwNlKykgpo42/alcW5L2axU+sG
 WhWjzgU7sYdbBtdLNW6tTP1hUD2XoSWEmFiX/+Og2XQuPj6S75CLeKqbAl11MKU4e3gg+
 kaw5l8iWFnJ5NRZHih1lRkZ3vhNHfwGm9HHzWfprHw0IbbaTFSquhZQwyk+4SVCtXN9MJ
 s+bmgjLtnN1/wQAAOirahH9Ui/6rx5oXbVPkX50kB0IR6iR1gM2Y4D4SeeBCbJJS1i3pH
 MogN24ZgFxo2g8jWhdyuGKhy7YSFjjVSh+aOdo5gNaSmy20q4ez/NV9WH4Boyyuofaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792049475;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=dQnYr7jp8ixsTSe4wYDcpgrG1Rl0Yer+yf9BUjK3VTU=;
 b=iAmOC7GU2OhTF9NpvYb3uebL77DXqA81bLZ1F7dNoUCpkqIzmv/9i25XEa15TdAyasGH
 /qV+zQGD6dA3K3T7gvB7+VENd1fzHW4pDaO7d/ergT9r9shUKtwCc713Eus02xIZ7u9Ds
 JxfemmZCydoBM5REtNWZCJm90psg6IBw23N8R/y8WXB6dnzCFB0Q8F0ElrvV6UB5XVgsw
 +vD6C/wmGoA4mX2POKgv0WriROVI5Z+1/DMWO8XdKxHIC9gQDeOx1tpwr3c2ivlR0LdTo
 OLKKP9PkiwCyw8yqee+tSvmTMSM/BvQnlnWId0lPgTCJBUbaEeAUeFInvYqrdaAX8jw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=VAxq7XI1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=VAxq7XI1
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C59A840053
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:31:13 +0000 (UTC)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7F78C3F982
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792049471;
 bh=dQnYr7jp8ixsTSe4wYDcpgrG1Rl0Yer+yf9BUjK3VTU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=VAxq7XI13qPtodqN9FslDP403z8zHCi0kRixdKFTODOxwkvWq7NxTUlO7kdUyjvQN
 RPsGwROBsCGFQ7EXNNFxwjyW7WcW01CsX9/q3BK0TWDHsPZVPmtweOd642dcsABiqC
 ydJEyxqS+m7y61xJ7NOzlT27tXQgiz5PGyf0ScKhFLVKwEwPAO3Ze70Uj/JmT8qPup
 +Xn6eKUKZSmBoEVsHwSYsPieS/JD9jHuERr9aadHBEBf8sxdV4bSSRETW4heyR3iQG
 udq6LUEbgzMvj/s0ogWMEZ2txRrTZFx2PltHj3eKrji+7bExXspiMGdFI+7FYu5mc1
 PHJq88oOoST0zT2UE1YtyOdWOyBMEx9ynu3Jh8OIbEd8fcsQC9hB9ceW+lz8LOTHED
 0qrj+x1tExJrGTbigzbIloHINcHL3QNyDhkmvfbfDtmQZnXv7b1cmQd3JK613nsvCP
 phjtGdTRtctepuD69tUeDqE4bFdlLuvcXpfzIjN1XjT2A5cRw1RlE61NwwyDbsHY8y
 QnH743OenJcCicHRTrFYFaZ3ITjJrO1TLjVvTgyq5Y95lcJ+f4jlTLv3W4WyKpq7x7
 3ntx9EDZCFl7ieeHtYBHCDwdwu6Hb/wweV8twqou5dbjTq1b2Sw/e27kry2AvOwqgH
 ZjlzVDYyqXjqNXAheXhZI49A=
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6a125f5b317so5661711a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 00:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792049471; cv=none;
 d=google.com; s=arc-20260327;
 b=E5Z2ad/iuGqV9DGqNfxk3oGg93k/lDEhuXgNVzPDNpqm7EmTCvTKdP8pbGGYJc9aXl
 xJ9Bp93cWKXlHDrT6MOQCKbRMQq2jp7Fk1CuSsoHvd9GRCEUC+7M90kVvu6dZGFHmQls
 sD47b1TP7Cb08SwKYu3pPYr/wDW4SI7hlPgI1uiWEuY/Hgpo9PY3Sya3V/4SdJT2taxl
 aHdKlnxLBj7xa9mtYxg3salvr3U6WBwNrpk/SleZpZ2QfDQuf4oagCQ/jRXpYE6I0SyB
 X3YAh8y8cBjqRkmM7LxH2zOdG2vC8dSSk2Ev/evAvgH1Ij/uSbrfn2NU2WWUEuJ/Fwjb
 a+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=dQnYr7jp8ixsTSe4wYDcpgrG1Rl0Yer+yf9BUjK3VTU=;
 fh=BLnF92CFMS4ds6P4WPfwpGWpMDozM2iXv3OSbw4iGD4=;
 b=fJba2GXquPqI0akI9q8CIfg7ECWu8gYGDMLTuKKOUqtY7f/Vga4LO4Nd0H3wBOIEmj
 ReYYtwcpQ8AubNXx6mXZP+fr++RG8z61kGhA5TqukzETvoYlbsJ/zpWhK5lKsstDgwSl
 Oh4Bb/XgIvd1mEIvLrL/x9KdBJJm5Bcdj3kyevjcK4OYvMi1pIQ8U+86eXq8J0wwaZO8
 7DlP7izKwq5V0SUmu8Jw76DE7+L8HP+7K3QO61VlUzGj+m4j9WIt4/IZEkweK+uWRRdu
 CcDBNJizPcBfJC9Ez6eIqKeaVsedXL/i3CSGuXk6NFaWGWHbq6oqTKQCeKg9yeqqqKnU
 relQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792049471; x=1792654271;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dQnYr7jp8ixsTSe4wYDcpgrG1Rl0Yer+yf9BUjK3VTU=;
 b=sbhYfMXWo/fekTNbEBYYhH8TpMHfOXc8jdpVHSz1MGX8ZoCrLzUPeZ/XLJVMwXTp7u
 ip/1vEnn9r1jCHLo4UA2vPtsa+HcRad4fSqMnjAcJ+k6e1UzIIVO1hLOMJmE7IDDYIb3
 fqDttQk9cE7RBSIbZ8lHNaLrTHczbcx285lCfN+4z2+v79Fui+Awo6+u999iu8hLGULn
 wQ/i5PZ3sZzMmrsh+qxL65ldi0slYTb4UpHtWZa6vu81uT8SD850TY98eKqraZFIeyL/
 TSc9lRwopoMdHpk3SgVhCAk3vJt235xDlQNTuL4L9IxYLboU5hezUfuEL4mDdcLS+Sql
 TMGg==
X-Gm-Message-State: AFq9FYK8Ld+4I/Pe77tlfsi8JEWZjWlSh9TX/tAIU7FCGV7L9zwmwOYO
 pdHRF/uPxj7FXojIdmRPumhF3SKHQ4OGVdNyCwuiiqpk6/ewG1i/ZJ3iFlj5vmSYm7llzy4dVj0
 A0Y50KQJIGK1IZElT07dzhm3gr4DQ5ICHlBELJwunWyeU4h8C5mEKYdtE7BKajgQ3wKWF2vVslN
 grSxjR9R7WSEf8+y5p9IZpWbI6bS/E29PlUoTUMyvqObk+mJgU0EqdhX9MTEytgra/7GNWeRzHG
 w==
X-Gm-Gg: AYBFou0p0FvfIC2GHfqxGNEkN8KMF9QVrTSLDKbwY7ytbZtQWSfa5S/nxsAua5S+VYq
 Hv301Rx9KRl1JuTifauHQ1eyoQ/YeZAja0oSKauqYBoKTdKfsuLGuXdOtvoPuOjMRpJTj5iWI21
 /Ws3fFKZf144aTaCaDmohrBkTn8u9ZeT8cTILC2TqX8o0n4J+WIhjeT4eo4Q==
X-Received: by 2002:a05:6402:321e:b0:6b1:ef16:1855 with SMTP id
 4fb4d7f45d1cf-6b1ef161b1emr5216809a12.18.1792049470972; 
 Thu, 15 Oct 2026 00:31:10 -0700 (PDT)
X-Received: by 2002:a05:6402:321e:b0:6b1:ef16:1855 with SMTP id
 4fb4d7f45d1cf-6b1ef161b1emr5216788a12.18.1792049470343; Thu, 15 Oct 2026
 00:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261011152235.8842-6-aristo.chen@canonical.com>
 <CAFLszTgpXzY20gjzHpAU1eNH-+w4QVaA-t5Ee7-0Wz0MVJhArg@mail.gmail.com>
In-Reply-To: <CAFLszTgpXzY20gjzHpAU1eNH-+w4QVaA-t5Ee7-0Wz0MVJhArg@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Thu, 15 Oct 2026 15:30:58 +0800
X-Gm-Features: AclHuK-QkXDGBiZuuliRT1KNLCkFUVoop9ZjJXwaPphXbNHRJ5dzBCBqmrg3EEw
Message-ID: <CAA=k7=kp+-Akc_pE0pHjcLiY0tkfRY5JW3Bqz07pzqmLLRMBxg@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] test: py: cover invalid external data properties
 in fit_import_data()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, anton@binarly.io, 
 pranavkasthuri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:27:54 +0000
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

On Mon, Oct 12, 2026 at 10:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Aristo,
>
> On 2026-10-11T15:21:13, Aristo Chen <aristo.chen@canonical.com> wrote:
> > test: py: cover invalid external data properties in fit_import_data()
> >
> > Build an external-data FIT, then point one image's data-offset far past
> > the end of the file and, separately, make its data-size run a few bytes
> > past the end, re-processing the result with mkimage -F each time. Both
> > must be rejected with a diagnostic naming that image. Previously the
> > first crashed mkimage and the second silently imported the bytes beyond
> > the end of the file as image data.
> >
> > Also check that a FIT whose images are all empty, which mkimage -E -p
> > writes with data-position past the end of the file, still re-processes,
> > since an empty region has nothing to read.
> >
> > Finally, now that the import reads the properties through the FIT
> > accessors, check that an empty data-offset or data-size is skipped like
> > a missing property, so that the hashing stage reports the image instead
> > of the import reading it from the bytes that follow it.
>
> I don't think this is quite right. Before patch 4 the import used
> fdtdec_get_int(), which already returns the default for a property
> shorter than an int (see the 'len >=3D sizeof(int)' check in
> lib/fdtdec_common.c). So the import never read an empty property, and
> patch 4's commit message says as much ('as it already did for a
> shorter one'). What this test actually guards is patch 2. Once the
> import skips the image, the hashing stage in tools/image-host.c calls
> fit_image_get_data(), which without patch 2 would read the following
> FDT tag as the offset or size and carry on. Please can you reword this
> paragraph to say so?

Agreed that the import never read an empty property before patch 4.
The empty cases only test patch 2 together with patch 4, though: they
also pass before the series and with patch 2 alone, and fail only with
patch 4 but not patch 2, where the import takes the next FDT tag as the
value (an empty data-size imports 3 bytes) and mkimage succeeds. I
checked all three with mkimage built at each point.

The skipped image is not reported by the hashing stage either, and my
commit message was wrong there too. fit_cipher_data() runs before the
hashing stage and calls fit_image_cipher_data() for every image, which
fetches the embedded data with fit_image_get_emb_data() before it looks
for a cipher node. That is where mkimage stops, with
"Can't get image data/size". Neither stage calls fit_image_get_data()
or reads data-offset or data-size.

I will reword the paragraph for v2.

>
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> >
> > test/py/tests/test_fit_import_data.py | 91 ++++++++++++++++++++++++++++=
++++++-
> >  1 file changed, 90 insertions(+), 1 deletion(-)
>
> > diff --git a/test/py/tests/test_fit_import_data.py b/test/py/tests/test=
_fit_import_data.py
> > @@ -113,3 +118,87 @@ def test_fit_import_data_missing_offset(ubman):
> > +    # An empty property must be skipped like a missing one, so that th=
e
> > +    # hashing stage reports the image, rather than read from the bytes
> > +    # that follow it, which would import a few bytes or the wrong data
> > +    for prop in ('data-offset', 'data-size'):
>
> Same here: 'import a few bytes' was never possible for an empty property.

Right, only patch 4 without patch 2 does that, and no commit in the
series has that combination. I will reword the comment as well.

>
> The case that patch 4 does change in fit_import_data() is a property
> longer than one cell. fdtdec_get_int() accepts it and uses the first
> cell, but the accessors now reject it. Please can you add a two-cell
> data-offset and data-size (e.g. fdtput -t i ... 0 0) so that the
> import change itself is covered? The test name and docstring could
> then be widened from 'shorter than one cell' to 'not exactly one
> cell'.

Good idea. Before this series, data-offset =3D <0 0> imports the first
kernel's data into the second one and data-size =3D <0 0> leaves the
second one empty, both without an error. I will add both cases for v2

>
> Regards,
> Simon

Thanks for the review.

Best regards,
Aristo
