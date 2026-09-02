Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E3EC61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 01:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1D3A407AD;
	Wed,  2 Sep 2026 01:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zkwXA1jIikaf; Wed,  2 Sep 2026 01:51:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788313874;
	bh=SVONeo7bN2IUFMKkF7BYuzDT2Gh9ZjoRA2RjiO4frZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L+CdeK638v+9p0zjospsPuAnm8A12kGwBe6KRsQD/YM1bAgTrc6a4y0EcaG40dkW/
	 AJqtuUSt34T2pmK21DKtnGHd6Xq8xDUvc4KlpccrVp+U/WgMLwYVjl3P58uMzXBS0T
	 9m/+wTiLDlHtsM1XXxT6JECO71xa4PY65vusuxlyrqU4T5GN+p03wzY7AhZo+JTQdx
	 PzKPNh0+3ZijFg46uTp7W+IuStiJw+PsUg3CdFO99WNdLwTYUwrCM4qVL7mUshyLyT
	 4lUFF7fjRPnsZZkXNF3G2pgiQUE3gbojTs85+ImmGhGyJbfoTrcYjb2lLEBJmUJaEv
	 UwNTxnJAVM8Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 604F140795;
	Wed,  2 Sep 2026 01:51:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AFEA2FC
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 01:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C81A6067F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 01:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBTCL6moOsOd for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 01:51:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BlH1cKBG
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C287660665
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 01:51:11 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d7195706f1so5154415ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 18:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788313870; x=1788918670;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SVONeo7bN2IUFMKkF7BYuzDT2Gh9ZjoRA2RjiO4frZY=;
 b=BlH1cKBGOOqot5VWPNL5Ds/xsCSJ118/fRn5sn6jT/PqNmkYzRBXusrHYOHrfQZcI9
 zDzdyGMdbqbYMaKuzbOdqPWaWWzP5xGADLA26t6Lbc3vkO3uQs7svhyFTP3hm/T8eLDZ
 S1aa2B9U+SPYzp0QsFUdaryRWdKsY/hxBr7dY9gSzS22AMgfznaGntO2pj8R3VC4LkGE
 buNFNC0f/9pbKwJCGENeGXHB1Pcov5M4Gq3ieERDn157E+JAH+FZrXLXsVyTd4axg90t
 UaK6jFh6Sq0xKMw5F3HMGPsWu08AIc8/4tN5jB3nVxuWBY9/Luk9HsRZIKiGS2VlSw+6
 KIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788313870; x=1788918670;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SVONeo7bN2IUFMKkF7BYuzDT2Gh9ZjoRA2RjiO4frZY=;
 b=OR6ZfffAWjlZPMthj2M3VXmoJj5OLLGJmYGXQ3bM69DSh/jHwGVfTULHYXK7GFp8+P
 M17I2cQHhqCmjZbjr4Nadfs6hMWQjIuGc5N+mG/Bg1hfLn7B1o9vkxmtksWFUoM3Zt3I
 H8OJRkvJEUcIeWXpigFbZmDyrYrOFjbOmHIUk6z06UYzSVNHhUat6K1O2b2P6ADKlSWL
 akqST5FNbbpN+L+OGuP5fh4vRRczLv6JPLHLZ09R0f2kB1o3e0QMSJzCt+ndeAhH2IX4
 EFG8BygvQ2+E0uZhrKyCWpgz1/qcpYvcstnZnZB9ILC5dHC414ivxs4csiqkjIX6te6f
 kLbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0bnYTqAGv3bMqYICrEzzQxc5/DcnpeVCLGFtqru4nzfrrsSkFsjFW4+wlFTfKWcOgRT7CDEg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nKYlChopouUOyvYMJT/RkfkGdMJ/CwYJi8uJwdFRYnU4UKnh7w
 Ke8XWMndPUmptz8kUA6O0cum3Xpsv0boFYhsylEm5smvfKhLtb98r/Rp
X-Gm-Gg: AYBFou25CicFBZdlVPia2QkfZ1LC55HPqDdLUvnbrvjlXiubWrWRaOpyw4r9NCObX7S
 Z3ET33TdqJCVg5lEA8siD4w9zfVMVZLQSD8afKnGQL+WNhVvoQADT3t/keULDxYMoTpRjxzGoKz
 IHZAIgvjlJr3Jv2AHquiQT1FIWtdSc7MhQJQmka4cr48lgTvSjaZvQ6UchAKOQVx1HjKeSO0NMJ
 dd+Xxyo4arXPRIwun5NoWpesVRDu/PrK3wgazbEfpM9m7owsVOgx75QhZ6tiFg5AuS/m9ghh72g
 eURc/ciDFkD9+Mvw35WE+gjFoRk7ZCJ1bpHj1/SncyBluP36rXKkxMs1wiD07G9syjzkYtWdXox
 d1frwk0/qSU6r6ugHrpuwxlI2/wGYjdw+6Z6hLlLwxpVFwrdKRrZU0hFa/EB2ZSEFKQWhylhJAh
 tDMlNHPAppiGhihapgq7BiOLgSKSOAlDDocDT7IWetU2qre5HJ0UUMPSJR+qUdDMUZsc29QDrDi
 bQTvj+PloOeA32exIH4Bo8+67+RHPwU
X-Received: by 2002:a17:903:b83:b0:2d0:cc92:f7a3 with SMTP id
 d9443c01a7336-2daec5d3dd7mr22743445ad.2.1788313870364; 
 Tue, 01 Sep 2026 18:51:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:46c6:e690:266d:b84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4885ddsm5059145ad.49.2026.09.01.18.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 18:51:09 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:51:05 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/6] fs: Add 9P filesystem support over virtio
Message-ID: <apeBCdth8Rj32qPw@google.com>
References: <20260829192119.2658328-1-visitorckw@gmail.com>
 <CALeDE9P7UoeyBNfJycD2dUHkEeXiFgi+XaP9hAzKTp+71fvx1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9P7UoeyBNfJycD2dUHkEeXiFgi+XaP9hAzKTp+71fvx1Q@mail.gmail.com>
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

Hi Peter,

On Sun, Aug 30, 2026 at 11:41:48AM +0100, Peter Robinson wrote:
> Hi Kuan-Wei,
> 
> > Add 9P network filesystem support to U-Boot.
> >
> > It allows U-Boot to directly mount host directories in virtualization
> > environments via virtio.
> 
> It would be useful to give an overview in the cover letter how/where
> you expect to be used. While new features are always welcome they also
> come with a maintenance burden so some background is always useful to
> provide more information.

The use case is loading images directly from the host into the VM. That
way I don't need to rebuild and repack disk images like ext4 every time
I modify the kernel, and I also don't have to bother setting up a TFTP
server.

I got the idea a while ago while browsing the upstream LK code and
noticed it had 9P support. I thought it would be cool to have something
similar in U-Boot for kernel loading and testing in qemu.

I will add this background to the cover letter if a v3 is needed.

> 
> From a network stack PoV does this work, been tested, with both the
> legacy stack and LWIP stack? I would tend to push this towards working
> with the LWIP stack as we're moving towards that being the default for
> standard U-Boot (not in SPL) and I wouldn't expect 9P to be supported
> in SPL.
> 
I have only implemented and tested 9P over virtio, so it uses
virtqueues and doesn't go through the network stack at all. It's
independent of both legacy and LWIP stacks. I am not sure if anyone
would actually want 9P over TCP in U-Boot, but if there is demand for
it, I can look into adding a transport driver over the network stack.

Regards,
Kuan-Wei
