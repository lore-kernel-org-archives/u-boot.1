Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47666CD4F3C
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 17:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9868D8465A;
	Sat, 16 May 2026 19:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="XuUdaXQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE868465D; Sat, 16 May 2026 19:09:16 +0200 (CEST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E95B845E3
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 19:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4gHrBv17k0zyPw;
 Sat, 16 May 2026 20:09:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1778951351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W50NsRXmYBUh1TyvJfVPKBh37jydwIvXd5OGh4Tlb+g=;
 b=XuUdaXQeUg9wO/kxQd0W/j3Gyux+fPvZMPEOytoVZq/7IUq2IZ/xYbKmpEzvfUPG4p9laz
 j65g4c0ZdQ7owgjvXPCOZzyjvHwaiPWTf3l02VoxnDPvU6Y31m8LrnO5HznHCbKGYWTn8E
 R9jb4J9ccEeqAtLg9VOa9DztH/4D3iQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1778951351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W50NsRXmYBUh1TyvJfVPKBh37jydwIvXd5OGh4Tlb+g=;
 b=Dh9LEwaoVc4SvRd7l91gJgeVOpeeMdAR4i62tfkG6ufmMJF0LVwSHS4yp/VSolCi/8w8Gk
 UsIOcQG6ConZ42+uO1IdI52Gyjh8Rbd8pU34SWWWe2OUOpfVKA2QP0oXYmiAhdmLcg6HL9
 oGz9UadezM5UcYvkcx/oTnijdxYstNI=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778951351;
 b=LryMQeUiM/w99FHepCRh+faggrdee7Q7RrbKYKzF6atlAEflJIb2bmM17HwgHYlrzaYb6u
 8KBg7kjuSMJ2KUa8l83Lvl8gN7OCZog2DAv2yp/sT+k5+FI5e1m4EqaYhMRdKWL1wmpWf2
 KWWEDWxmhFvRW5RV0L7BGlijXDFnmL0=
Date: Sat, 16 May 2026 20:09:09 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 jonny.green@keytechinc.com, trini@konsulko.com,
 simon.glass@canonical.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 01/15] ecdsa: fix support of secp521r1
Message-ID: <agiktUnWJV5WzXFD@kehys.lan>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-2-philippe.reynes@softathome.com>
 <CAMDkj5xSEbEkHPrsJ2ZnRZ56BsiZXTKV6RxoWrJn-oZfZBi_cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMDkj5xSEbEkHPrsJ2ZnRZ56BsiZXTKV6RxoWrJn-oZfZBi_cg@mail.gmail.com>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Philippe, Raymond, all,

Wed, Apr 22, 2026 at 02:32:22PM -0400, Raymond Mao wrote:
>Hi Philippe,
>
>On Tue, Apr 21, 2026 at 5:10 PM Philippe Reynes
><philippe.reynes@softathome.com> wrote:
>>
>> Current implementation of ecdsa only supports key len aligned on
>> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
>> aligned on 8 bits. In this commit, we update the keys management
>> for ecdsa to support keys that are not aligned on 8 bits.
>>
>> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>

[snip]

>> +static void fdt_free_key(struct ecdsa_public_key *key)
>> +{
>> +       if (!key)
>> +               return;
>> +       free((char *)key->x);
>
>It is safer to be:
>if (key->x)
>     free((char *)key->x);
>
>> +       free((char *)key->y);
>
>Ditto.

Sorry, did I understand correctly that you are requesting to add 
redundant checks to prevent invocations of free() on a NULL pointer?

The C standard specifies that free(NULL) has no effect. The
implementation fREe_impl() in common/dlmalloc.c documents this as well.  
I think that we should aim for minimal code size.

With best regards,

	Marko
