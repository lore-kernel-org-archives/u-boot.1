Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36E7CA5FB3
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 731408113C;
	Tue, 29 Sep 2026 22:45:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DCqtRxNCml2r; Tue, 29 Sep 2026 22:45:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BF2AB8110A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790721944;
	b=Is2Ugnb6O5DHvdk5osj8707rpJR3XtxvTFXeNHBXoaTrNgqA0W/9LNFpBO4esHzYsX7r
	 84LmRg0RciE5CMeoH9oDSjGnu6ao7gFdwQ5QmZH02EzVO4W5D1un/x+1lEcZ/JAsr7eQJ
	 7dY7Ul9SNDB2jN3a4MjAlBhU7sUGS05atzBKDbzBARrvxN97ARdZhyuXFr2+0fehYCMNU
	 bElxa32bXilvfhtPW1zQdtYJle5KTF2Kl5TlP8RuySs4YPK9OVX+Fs9eBWQuZIcMRWlba
	 2tBO5iNXPyzl2OJXmfoXtqEDM1sfSlK3badETt9gExylE6IWouA9L+TkdFrh3sckqOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790721944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pT61XNr2a9b7ZqfjpEMo4FYK7HVYj7z1SmS1nW5GJI4=;
	b=nq9YyLqfZSgcNBRwI9KNJpNIdaD7iN94RCyl1ZSKO9VHzOqhyk4l0T0e5BK+rjrwWM9K
	 FVFHeDSenC5YJqMGcDHIZZNxdGiEyGB1twak0M+czySnMmbsGzxtuXN4xIBnTpQUA46a6
	 aJeyJWXOkg8Jo+1LIU5JBubwHg+xLaf5OF5ytYTSpMJ2H0EU4Veaij0qEZunEsiI7hcHm
	 EFcI6LFy65H1nAqDMjkbzNWysDDP49hrvwBKQIS0QXv5wUHj8YUCXqzkxKUv2j833Yz6L
	 WtXsK0ye5TmSLrfLZJTmScbB/2EDo35ipQXQX10/xAoIWQ9/iqy1esWDJT6rRpRAEpw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790721944;
	bh=pT61XNr2a9b7ZqfjpEMo4FYK7HVYj7z1SmS1nW5GJI4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kcltuADGXBvsuGC5D7f+o28kzJOQ+s8WzpPuNFf9Bi9kwAaCLhKpNN382yQr45L9l
	 NSRbV+8dSHOFCcI0pVx665Z4HmMlmHJDzc6JH13te34q6xcrobQxAIMAha8E+MZ9CH
	 S+EzSAgXsxEd40nq2sE+hspYf9nM84XM4rpk4sevcZJL6R+grFBMMbC2t2nu/QgbDe
	 ylmu1PGx+HEecybJfggE5k8MeYNWsfu49K7Do6IXzwG6PAwGWZ+wrm9Wb3rZvKpcVS
	 FLDv7LjxbEOkUDbSGVchEGo/6WR7HMc6r7V8U8QKJK/1ICqXNXO5luIalOplv+sv8r
	 tculFiS9Qk2Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF2AB8110A;
	Tue, 29 Sep 2026 22:45:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 100C624E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 017FA60806
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZbVBz4MiKhNt for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:45:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 42EB7607EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790721938;
 b=T+qcGm6dquklSKbxfeaPXe0GROJOJ6+AxrDP+UDspIIHApJdk4kyIOVWyV8JLrp6Zcj+
 KllPTVna83v7cHXb1OzQGvEQ6C4BHCs5to9Z9AzwVbwCDKOxlVMjmtbKG9leOTCifbPYY
 JAor6AQfBEHCVom5Ym91aGVbPcORsCDGY32gIGlIzRg5X29ZZk7DuzWZXgQv417LXUdfe
 TZknYaFRh4NSP2swSDOMU3cPsavLQ/kjUfAU+lA4rAHBynVUp5cKeHbo+vz7a0bBTjzR2
 e7mU9IYNmSOp9VV68nZ7VrGYF8ZTyrO5QIyE9CYZL/6ybwORN5FmRfuOfYX32i/sZBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790721938;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=pT61XNr2a9b7ZqfjpEMo4FYK7HVYj7z1SmS1nW5GJI4=;
 b=S8V91uiwDKym78QXM7hNts6rPkZSyCKvNKyFPu3fzfIBNJYyAYCcf4F87knC5vFKTIF5
 SLidKdp0kYLcdyUg8LABFCFdufRDf4CrESqNDUhqe6s7TyiVr84EtlVO21OxjK0YUm3sK
 LVDYWenOxbOOIgDbxrvJnog+fnROrf+1ICLaej22Ritk9xuUXRodYhpmjFh7P8mrXlBO1
 BXmK+QflzbtMq8w/ChuLikzEtv0qdWAlztVYfOLYQMp1GZepsaglUSsPAbRg2Toskr1lm
 itPTAe1AaSPtO7QwG6r35wLXDOcXa8BBBv91qnVfsgcg3KruY+LEUCwewTO/Suc1fiw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Z+DPy3Aa; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Z+DPy3Aa
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42EB7607EC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:37 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-80a71781323so2891381a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790721937; x=1791326737;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pT61XNr2a9b7ZqfjpEMo4FYK7HVYj7z1SmS1nW5GJI4=;
 b=Z+DPy3AatHfivPGa8jWpE6OcSxv0VQz09jR+mOOshCVoJ9iY//lrm6r22DakZFDeWh
 j5oSjK7tWnExhRWSrohNwJ94Z/Bi0UhmjVmsU44GnAuPKF6FU/8J8Ob1qDX1omQv0Y2k
 8UPN/GCJG26oqarP6W/LMF3YQ19tD2huUnCnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790721937; x=1791326737;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pT61XNr2a9b7ZqfjpEMo4FYK7HVYj7z1SmS1nW5GJI4=;
 b=tpSaHnMUsADY0q1IloKimhcFOs30M1AD2sL5S4cNV60jqTQAlzv/vsxXoaHa16/SMh
 G5Op0sEqOFg9Z55acyiq+IgOZMfnDnsezFSn/2v0DsH3Jgvenk9pwq0G0r8IFVCTezBA
 3QAjGu0yJ0z6wcm0an1Z9OaIIGJoRQHpz4csIyhb58UILbmXrk6/3CWYPnhke6LZ9D26
 I7fMgdKzdzwR/9pG0evKk/fd/NmOwgs3ow0pmf7dsVj/ZzA5ywwVOoyAI4wsiFdU3kNn
 /GaRU6Yw2Kf0Rxc3QSmGeu7nMSO0CSzn20W982NX8MFtvT5x+Ak5bKlvzFvHc1N9WkhX
 aplg==
X-Gm-Message-State: AFuF++n6NhwD9LNP+476nxjECIpVX+iWc5WR5ZaZibLWebwU+KZ98gp5
 d5VSYV+vNen6uV/poVxxDqryv937w+mfXROV/5IDaRYUtsz7lharGX9yKZiYFMufjoY=
X-Gm-Gg: AYBFou0XwDXo7IFZaWXXOYNXhvm1Jn1WL3Lag2k+tU5G7vHjusN1RLGVgU1mTTPjPzI
 m8iJ5/lLTfj5tpNRiXc82e6nwvk878cCUmbz9hBK7x+ryfCWaNf1w39AurKw62QUjvecR7HtC7F
 R9rt1PpCSHFLxYGty6GJCJXm7HsQ3YFJ+ER4zx9QAYeMcUNljHCmCWoUrL3U4fnOSV2oJS/PIMA
 QkBj6iP6oGdBX+Q73QhOsnOTffx7DIA3W2QTMatX2JQhyqlxNYtyAhyJqvHCewnkMjMpCN4XgtP
 mtXIXV7iI8zE8yFul63jFwfZ0pcfYNMKcqLyxaJgNMHpEbiButQwMHC+Dz7azj6zpFq6vGYikPZ
 +PZeuNpA5DWe/xNL52NxgZDDaXfJdAfAfT/cRrrXoG8/JGhgftYOUiYFUJQ61PuSleZvmeIdiTV
 xEOUpdkvMjBLddfDUVNSmK12TLV931ZDh8znL7gEQUQ+wA6C4WALVyJz0Jmr5y31MRpN68wsCQ0
 TRc8Tu1iS6vJ9GGYJEo2Q6wT6nUn+6dA375UmyqVsHcUbzpRLJj09v0U2msRzMZ7aMfL5sJ5bCf
 DvAEC5W70nNmz1fwNDmkMpIm3KD17A==
X-Received: by 2002:a05:6830:258f:b0:81c:ab45:3040 with SMTP id
 46e09a7af769-81fd38058b1mr851351a34.4.1790721937004; 
 Tue, 29 Sep 2026 15:45:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81faf7eea80sm1159921a34.16.2026.09.29.15.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:45:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260907074221.3718-1-aristo.chen@canonical.com>
References: <20260907074221.3718-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 0/2] bootstd: cros: Validate keyblock_size before
 locating the preamble
Message-Id: <179072193591.236406.1792991621986615188.b4-ty@konsulko.com>
Date: Tue, 29 Sep 2026 16:45:35 -0600
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

On Mon, 07 Sep 2026 07:42:16 +0000, Aristo Chen wrote:

> The ChromiumOS bootmeth reads the first 4KB of a kernel partition and,
> after checking only the keyblock magic, uses the on-disk keyblock_size
> field to locate the kernel preamble within that buffer. Nothing bounds
> the value, so a corrupt or malicious partition can place the preamble
> pointer far outside the allocation, and every subsequent preamble field
> access is an out-of-bounds read. The values fetched this way then drive
> allocation sizes and disk offsets. On sandbox, scanning such a partition
> crashes U-Boot with SIGSEGV.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] bootstd: cros: Validate keyblock_size before locating the preamble
      commit: f82b14174f71cc3667ebb86bbb9a7e1345c6ee17
[2/2] test: bootstd: Cover invalid ChromiumOS keyblock and preamble metadata
      commit: a127ac8c99354bcb3415a365677eb626ddc6a289
-- 
Tom


