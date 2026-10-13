Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3DCCC6B19
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 20:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BD8980CB1;
	Tue, 13 Oct 2026 20:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ih_MXpeSv8w8; Tue, 13 Oct 2026 20:19:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5AD5E80C50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791922793;
	b=ScEFdsxAcdKEm5mGX3klTnyINpxwefUsj86x9bGLfJZQOA0eegy3kOoaeO48+BJw0xA8
	 zfRmrXwgoZ5BB68sHpiAdD87uwNb99zBdYKIk7xtJHTv4tkiokXABwmPYyl2UNwA60D3K
	 racVtV6KolaCHPznJYGa6pV6rHMD7xdqDavni/Eq4/9f1XrDB1WYIj+h2yUORTvUy8rHD
	 lu+s4imdcEwdgVvF3AV6KkYdOTiIocm1tzyU76iA5vDuZCkIHAP6f/MD6E97U/kld6bSq
	 7ZyecOW//JYMOUOt4jQi0rHZGcj6EJm4ZoaqKrICLMXT9gKcVMojmT92wvYSTRSpPdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791922793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qumbnaLnYXX4giJ6weQQyWMk8ZlQ75uE3vsuPlpFuko=;
	b=Lii2cRI0uWiwO5BK4hzWBiMvtYhIabZP5oKlvG5paQVaHbNd5XQIExgEeMyJlZSlEjS1
	 y+dMwW4fgwh5SVoziKIstkXyB4Hs6EbMXwPYkVnw9Ms6fFjsZi0ViNtZYzbs2IkUQKmzJ
	 5unVmx/88xa5tFnmvaFLmB2+ErILGE9kKYaPPzqxtDL/qDCenENdTiOO5gDg+04ZQTcGI
	 RunAKPY0vzkSgu4s82NjS2fnXwmklPbjiQVfqPxh88BBr3RD/Sn/nsniPEVW7H7jXIXCx
	 +UqvZ+nHAxrvT8ctET6bnvlDRe2PlYMiO9PfXf3QnnD2+a+y0XNT3Uuitg7oeydfVlQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="jZITx/4/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791922793;
	bh=qumbnaLnYXX4giJ6weQQyWMk8ZlQ75uE3vsuPlpFuko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n86TbysTO4PlTCuoxwCq9YCQimUhLCyRitOMcIskM6MHXVhcey303nMk/DOiil6/V
	 RItlMzTQwQxNR3BIpeAJufbKUjLThRuIjVC4GQLX8sKC4NFyjIBSQPEKfdUEgb7HfL
	 sWt6oI6uGG01FXK0KNFL9WaB8voAcBv6U9Uj9ZZgSi0PJc/PGYdmIuYmsPLvM33RY4
	 cC4/P9awW106erjQKpzubmMWc4GgwJSNVUE6ZI2+vvgsWWFR/WAByhSkNx6oVoGWLA
	 TieZ5fSF73/iqZ2QqH/n8izQLMvrJushZ3f63NnSnqJdGwCm17Ku2L8iAdTII3KG/k
	 WeMPzu05dzFTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AD5E80C50;
	Tue, 13 Oct 2026 20:19:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB7C01494
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A47980C50
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IyRKqblcVnFH for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 20:19:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CACF880C8F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791922788;
 b=cgU1bGfkwhdMVPp84gGvVb1zP9od3C3EclIJs71TBVuqymzHqbcAG3rwZkcU9rV+qxKd
 hDf//BvdKLlOt+lhXDCe0dpnle5Yuc4BhPlIevtP4dbXUum/KhsD9aSD44G0ePHZDggFq
 HodZJ9aXZL/0hHCRJzC3PSUgpsB5grM4oDhder9kWTmcwhTa3mLnSEgGGosFbGmHAo1zI
 s1Ehkoa8VVuHY9W0oZjW1v/Eh2RHrC2MCn4sKdL327bydWPGN2693AZkueouR/llsqYNG
 Qzh5eY8aiDwYJbRl8fXTqo8VXsHhmXg8l2iHiHci1xhRJJvLCmmdsvvBqXbnx5od6YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791922788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=qumbnaLnYXX4giJ6weQQyWMk8ZlQ75uE3vsuPlpFuko=;
 b=QvZZgvrvvycwIkrbGi/mPG0YJOchFxyaSd5aYQVBR2cHUWQPVLoftdUQ8GL5UL9qqBRG
 rneaOUHk3/t+/u4e6fCEJgOfLN7z9BAIYircKNKXBeK+/X8IwoqJiE/8esoGVjkEob9tq
 oVJT1b3XTuZMdJX0NgADVsZsEEH+dDIy+OCova9yrGXECzF8LvpTgJ/E7mDAVsVbP7tmW
 JgCyP0wnhsM2zXUWXua58GKY9EmXfkVlP3hYYi2bRTARkkm69+13qrgdA7+HDh7pPCbRx
 7pcFgUqNKBsTeYbS5qs6zpEgkmgxG5/OsumxK1yz6DbQVi8SBXSeDLlWfRSgE178rFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="jZITx/4/"; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=jZITx/4/
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CACF880C8F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:47 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-483d290f398so2060138fac.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791922786; x=1792527586;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qumbnaLnYXX4giJ6weQQyWMk8ZlQ75uE3vsuPlpFuko=;
 b=jZITx/4/ujDp95+rcM3iPYRty6ROziKFtxAw9cLblcXG5CNVhijp1RXiQjXgNdWTVW
 Mu2y9VUWi7cEp51OKG4JM5GLqXeHXbiltMlqxNlE2mr1YRXweO7Ij3uh0AH2t+q4Ox82
 /m34r8t8h/wD7q0qGmiy6Y1yoD9jCaGqX9PUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922786; x=1792527586;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qumbnaLnYXX4giJ6weQQyWMk8ZlQ75uE3vsuPlpFuko=;
 b=YglhVmu6Ndd7o7NZxwKl4Qvgkvka5ScQKqHZgCwXQ3z5pOsLBplC1z69zJ027dS9Md
 0q+ZuwvKUONaSCeUijlNI53bflVZ1pxzqnu99Sh3olrv5JyeaUJ5OKfWnnp6yv7AgJcc
 yMkXWMfoYyeVrDHnCR+PEGBG1yttQBXC2W6z3M3IgZt0hhFJT+7swGzPsdDMQpju2M9y
 TU+rm/zddyc/LAwwSJNt4y6oZESIMILvma050YnoV7UA100g0c0HRP7ZBJPpc7aq8XkE
 RQBPi9yCCvVbJSJZM4yvIiexAgdGB3jLaqQzaAIoX1WD1jF6TY8luMqfcSB5Cbvr1BwL
 1I5Q==
X-Gm-Message-State: AFq9FYLnX1+usdQWRGBLg3a+6fuodxyn26erVn0nsCYqmynNY62Scodu
 AnADeRqga5pwweYiDx9t6n11CT/HrWvUWiXgE4q/4tHfZWr4kS5XX5eLP/Ei6iyOXH0=
X-Gm-Gg: AYBFou2eW//kn1Dc40+tHjS6IST0jggMOtiMa/yAsKW6W2eyfEcxm0R/5VsO54cShod
 lZErWVP7tvOPFLhPvJEjKUv9GlbVgo2nW88zFpF1u0A5nLiVWMbHLJp0Xc9QlQvqy1vUJfeEHAn
 g6GzO8pwv0p+WpMAiRrw438hYQwXgsg5LwJDN3RfSvT8GiF4gbbv2N2rfG6zukBtnSENf1a5Eri
 Ztpz9WVwRRLKcYNoGEASfqemfmzRT+r70hu6LjrnR06UCUt6smhNqZYffCpB7GG4VGwYL9F3hBM
 w1FnImEScM6oKCAN/sxCD8EUKn7zWLfvWaKol7e8LCE3fQ09b9DcrdsW0CFwctaTwqDX3OuJFWg
 k6APwUKVLcv2/o+Ac2txm993Z/hqAsOXqj0jXNvBT48AAJTb1ZK0EvVbkQrLO3JD7sFUvF3IyXt
 lx04f1ZDA7VApSyhpv5jLq1h61aG4opmbLxj170SHNi+tXaYiYnlPOyrQtbDZ3py/ijT3Iydy0/
 IY8L99wr57GzGWxXWZoHDbSbGs0qKcPZRO29xBPIunFx9XCGYVDTV8XFRQm16s3oUFyUAZYFipX
 4qD0qDZBX0I8Osx6FQ==
X-Received: by 2002:a05:6808:1786:b0:4f3:890b:5fee with SMTP id
 5614622812f47-50c4c7a522cmr16735009b6e.16.1791922786072; 
 Tue, 13 Oct 2026 13:19:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1c120ae6sm15016505b6e.17.2026.10.13.13.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:19:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Graeme Smecher <gsmecher@t0.technology>
Cc: This contributor prefers not to receive mails <noreply@example.com>
In-Reply-To: <20260930170743.2141954-1-gsmecher@t0.technology>
References: <20260930170743.2141954-1-gsmecher@t0.technology>
Subject: Re: [PATCH] xyz-modem: only strip trailing ^Z bytes from the final
 XMODEM block
Message-Id: <179192278494.4115168.9830745922492308539.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 14:19:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 30 Sep 2026 10:07:43 -0700, Graeme Smecher wrote:

> XMODEM carries no file length, so the sender pads the final block with
> ^Z and the receiver has to guess where the data ends. This is a
> fundamental ambiguity in XMODEM which can't be resolved. With that in
> mind:
> 
> xyzModem_stream_read() previously checked every block for trailing
> ^Z^Z^Z (three EOFs in a row) and stripped all trailing ^Zs for blocks
> matching this pattern. Two problems:
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] xyz-modem: only strip trailing ^Z bytes from the final XMODEM block
      commit: 03e0ee96b1cf21a20def03c079ca05427ebff208
-- 
Tom


