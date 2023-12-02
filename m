Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5D5C10DC1
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 19:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D140877B2;
	Sat,  2 Dec 2023 20:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KXDcHvtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C58D1877B0; Sat,  2 Dec 2023 20:38:14 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5D5877B0
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 20:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-423a7dd0803so24326241cf.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 11:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701545891; x=1702150691; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fUgLAnuilyvmu7BCeZsKaMKpUxMqL8iQyM38OrLqfeM=;
 b=KXDcHvtqfOUYEiLUdoaNtSoA49JCf+WDiFCYdPs1vSCWyNkKa1PhkS4Iy/n3AS5AgF
 Z/seerQLoz8GDkmHf0W4OmAK++4lQ3qn1LEJ7FuzB902PnehsyAqnM9o5iBuyiuZvNXZ
 T+GhKqJsRV+Xs+LLVfFMIx87z5yoODN7OxF8rby7ovJuTfDrss0WH9L8i267KLkB49EB
 BeBQLVcPlhAsRak1464CwKlX2veZHf4jykOGjxITFyjIXKb4sUk2tbFcwdHDw92ZVLVd
 wfwVQ19qXnPHRGL/Pc83Er4AvQBDSFqei6qJ4k+roXr2scxqi2Hql8653DMVNhc4gt1p
 G7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701545891; x=1702150691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fUgLAnuilyvmu7BCeZsKaMKpUxMqL8iQyM38OrLqfeM=;
 b=On1lJxd1Ahac0anJJN5gOKO+FkzpLH4O8OkejhCXDh9TRtvk8/pkVVUJ7yCnzFhXbo
 ScAL6SfNt/+RPDxH7QDNcHOCLvWN0t4ess4BNBF1oYzAFPA1veqYk/VmfjZ70Y52x1XV
 NYqYVh/sVdZ/GOAJn5kb+EMmIwI5eJI/ydR4kbQ6zdjag63/e0abXe/3DQuEfkiPGGk/
 IXmLt5gnv7r4cJcrmOkPBOyG7AR8qctBYLoj0v6nLfyS1xz81nAj0w46XZps/4l/bgIq
 5X86Bzp42MBlDsWsfwaRkxbxLYquL5md8tIFuQZkW9g+q09KuwzMq5dDAxuI6LKbKDjw
 +TaQ==
X-Gm-Message-State: AOJu0YzB1B/v4sJR7XDoQUIkCI2a4F+QVbs4f38tV/11DO1Jcl9c2RJs
 Is0TUPs/hsem5GHQz/PjjzW8KB35Efg=
X-Google-Smtp-Source: AGHT+IHBBUnhXv6wIwWvGtbbovKml44ryCV+p5CP0mdwE0UnzH5yaIiR58Olf8ZNMilv4hU0Tuh08w==
X-Received: by 2002:ac8:598a:0:b0:41e:ae5a:2b96 with SMTP id
 e10-20020ac8598a000000b0041eae5a2b96mr2978821qte.13.1701545890693; 
 Sat, 02 Dec 2023 11:38:10 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 he48-20020a05622a603000b0042387bd254bsm2674215qtb.9.2023.12.02.11.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 11:38:10 -0800 (PST)
Message-ID: <896d4dd3-d023-851e-e7d8-3bf4d324f1a4@gmail.com>
Date: Sat, 2 Dec 2023 14:38:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] doc: Replace examples of MD5 and SHA1 with SHA256
Content-Language: en-US
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20231202193314.1513224-1-seanga2@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231202193314.1513224-1-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/2/23 14:33, Sean Anderson wrote:
> Both SHA1 and (especially) MD5 are no longer as safe as they once were for
> cryptographic use. Replaces examples which use them with examples using
> SHA256 instead. This will provide more-secure defaults for users who use
> documentation examples as a base for their own use. This is not too
> necessary for non-verified-boot scenarios (since someone could just replace
> the checksum), but I wanted to be complete.
> 
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---

I forgot to mention this in the commit message, but all the new hashes were generated like

echo fake kernel hash | sha256sum

which should be fine, since the actual values were just for example anyway.

--Sean

