Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF90EC79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 19:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5141980CA8;
	Tue,  8 Sep 2026 19:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OVVKEslSyMlg; Tue,  8 Sep 2026 19:52:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 98FCA80CAF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788897157;
	b=iO2J7U9dpUuDZsu0+V0LZ7zwWwjscZOrzXm+QqHRE2Grla3E6/xSwP59rDKiRPKDSTlS
	 AUyGURaTM+iGShymdxCQ7QLoekuV+G0ETat7TB4g2Os2Yf7XTwGLpwTrgJSVMUoeo8FR2
	 lEIq2w1ObveEZ9BoimlKs2bAK54u2LYoPrnACzxA6dLJ7MZovM5n9AMJRFREUSCMCeM20
	 ohnwxVThiBbQNyGBBG7I0B3OfB85CR+OIKltw6tMpj2Gc+Bi6kvycXdr1O/5dJL3dS/VB
	 RfNBpWFIB6O9ALl2Hn9AyQ3Zf81vdTvxxm2dyBXL8SDAB6A7B8i1SyX2jxA+ZlJwJ/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788897157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=w23oy47SQmZ/W227hNSMPqeu2+Fsz9hLI32fikA+H6c=;
	b=OEcrXVj6RDH6jW97QN8RxAWuGhmg+a4Z7mAF1lsReKp1KW/ojYL9qX05BHH/zpVYVa4S
	 QwwbbkiYf7Z9CP3TKNbhqANAcmRDCLfZ+5l1oS71NCDDHWOcktNitNLU/S+iIn5IGZMIx
	 Ajj77vH4oONUfonv3Gh6+dwOrJIJkIDLxdvRhzCCyemAtyloA+m5EsrLs+1BFixgQkxDg
	 SEaVfBDzjFwz7PCS4iMWOITvWba1NQzTfq3TvdcBnKuT2bGyUnCOSUkebJaSs69bPApGL
	 Hq3VP4ctqH54pXcqUebQHMlODa9O5YbT3WR4tKly7h+MK1sClN6UVUf7TUaTumieKyw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788897157;
	bh=w23oy47SQmZ/W227hNSMPqeu2+Fsz9hLI32fikA+H6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iibSxFDnNGL8W10VtsojqF6lQgRCEa3LbzIJzeV0CIyXX9lNj3RVPjYRGkPkOLCVF
	 8zojFPY9DN8CzLQovejjR5yaMEgAw9Aei3Uj4H04Pi6y0aPm8kBWQHuDdkZ1KDC2kG
	 aOaCsDU18Z33dARQSFIegobPZPFE7UkD4giha5ilthv9RhzS1ocM3wM3iWFPPGPvL/
	 DzSWHViqVC/y5UJchkozjB69U45Yywm9v348T1ZLbJh3GB30TarXGpwRNmYDWIAc4/
	 RUoYdP23Nu1yy94I0hMGcgAx7zMawvZ8Im8/NUYEAQXEOty1GwU+kV0yHSUHxYDOGz
	 xfQixqPSJNSnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98FCA80CAF;
	Tue,  8 Sep 2026 19:52:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E86C769
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 19:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26D754018D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 19:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kmxs2Om9ZJ3e for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 19:52:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 638D64009A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788897155;
 b=OFiGNbSjoX8aPvZzKFv5DwFjH8Yhx+L51XShnbKYHXIrdQXUYFAZVw+Oc07RSprq0kG9
 DTD16h8MEh5Oe5I8Nuc0jdIsTyBQUhq09RnePw/8nzKePoR/UE/mZlCicwqwP+moK89KT
 uqZeEtB2eZTVQu0qsN2rEdOXTsKGV0CMXxuRjiR3PkeeYXK1tqxeEJgFn3ISZ/Opiip/O
 Hzo9G5Md/NgXRjKiuKKpLqL9/0YIEuMnMkrW7EHycGaOIyPB1kknWSL69/kaUPquBg1S8
 w4ilqdQ+nEX6xyPck/K3T/V1We03rG7Ec0wQwUBO8TJhAX5hGv8gCjqY5BtZNPcWQUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788897155;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=w23oy47SQmZ/W227hNSMPqeu2+Fsz9hLI32fikA+H6c=;
 b=RhMvAJH+jMa5WmNjTpwdQF5WrDGO4H8a6K/1QN0nhXbVkNXMqdsl/j0r2P5zdGgrjiO1
 DOm/uEsGm0cH3+6xvQeAiH2dnHtmR7VujKKc5fwpnTNqYiZUrXbLutZSLUFyILKB/oY53
 JfgZQKz/Lp25QGO52sz4cNygBZf6223CkS/glLUsypfct3xykh5box9pJLl+SBnGuxe1V
 Ze66W94PBwwchaSAxaM2XgJktvnpatXgw6L0g9V3xCXervVrJqxUcwGeLLrDLRr5h0TGS
 fjMVgG5Fnc6pDFnr93fCvKpHZ0eKxRA8mWLCzWu9BRClUsnFs9mOzWjCxNliLBYTVpw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YReDVnAl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YReDVnAl
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 638D64009A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 19:52:34 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7f4e596e393so5034971a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788897154; x=1789501954;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w23oy47SQmZ/W227hNSMPqeu2+Fsz9hLI32fikA+H6c=;
 b=YReDVnAlTnUAuGcnPN3fobXaCxEzWRDtd1phkfly5UV4flzu5p/32/E8MqUkHzChGn
 GvSxrjxxbKbQnoLUUignU1uxiqisvVo51qv5Jb1IdVB2okTsauC2wC/8yo7tTTSvu5R/
 Pv1iskE2Q+72lHOggpwIY7awKXL+REiaJvcgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788897154; x=1789501954;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w23oy47SQmZ/W227hNSMPqeu2+Fsz9hLI32fikA+H6c=;
 b=FVLrZW/yvlu29GYjb8BOVapobX3uxquWQ+7idv+bxzwbZHF2Mvbc5FiONkIlCujhox
 PSdJQVC9HIykS2JZwTpRa0fm8Ys8v4emGHhMThGZayUowKTUQkFCAtr/7PXq/J97NW/v
 j7Ke5LXxBZogP67UXYDQ6M8jzBRbpf6Qs6GQzQBqX2+fEqU3JzeGGMe5+gCjha1j0WH/
 kcOgzDsTWf+9nMHH9GZx2Iy8l4U+XeTIKUYSIV6BsTHSFBJr4/jWPkTuoS7X48hjr2S1
 Me3be50DWC1Ygm2CxIQExafEm2YyvN+UbqUWb/QWd8ilT2tqMgdmULSSZj+3YunqEcPJ
 v6sQ==
X-Gm-Message-State: AFuF++m37XdY1/yL/oKyYGryo8GZhW2tRvD63Ji6Xt/aDdZRYZGGheAP
 noKLllK1sfqBTO9cK8YOFMt7q8q/3V7gvJ5ZRa7kDUqjQfqMRNLatxU3DgY7WSC2qGmnEv1B9ds
 WPSg1DhOpQyKK
X-Gm-Gg: AYBFou01bBgy2pTQWBI3uuSs0mGIpKa0r75HpiGo10AAJcOqQss8+j011dRgVKAwMTw
 EA0noeTmTNcnBMQRj+2LKOV+5TUGPi0fluQCy7Ca0ev+xbnBOzSxWkdJ9X7qxUaE73bQYjRCKNW
 MjCirlzd4wnXyZXVGQuN6x3f7zTLN+3qVlLcxDv3ji+T3aqR1RSLi+lTyDq68Q62XKaJUTFgoXy
 wXOe2lf2Graf49/9SfQh4CGMn6JLMLsw8DV0X0/JJcy3sg0eBu8bOyeYLpU2Lx1cIjKuo0ejVkJ
 WS6TRFNblRqo3uDxluCDeLDxNv03fvjEhvaY28C0q0u+QrlBbHXYSpbZwZTDpwatUMGhNm5Vflj
 0W/Su/gic59D6uRsv2SVhP3NWs1nR4EEokSlwCjXF3NRZn/PY4F+bhOpa7qsr/F9IlsFqqSE4jI
 KTbr8thwz7xKRUVLgkhp30s3o3dmLVMluB7NxSnhSV4+/MV6a9NtbVUXXpdkBMZb4WdDv2hMaCi
 J1C4TUHiGDC59WVXqXQp3FA3AW69yz4qyn7NO0hbZp76qnnpdo2ZlAueVpUrc+95BfOsCEpIEhK
 D4Yta+jA
X-Received: by 2002:a05:6830:388c:b0:7e6:dc7a:f459 with SMTP id
 46e09a7af769-7fa1fc6530fmr19557847a34.11.1788897153856; 
 Tue, 08 Sep 2026 12:52:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f7aef680sm15860426a34.26.2026.09.08.12.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 12:52:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, alice.guo@nxp.com, marex@nabladev.com, 
 Max.Merchel@ew.tq-group.com, stefan.eichenberger@toradex.com, ye.li@nxp.com
In-Reply-To: <20260907011340.6031-1-festevam@gmail.com>
References: <20260907011340.6031-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260906
Message-Id: <178889715283.1466431.15935998328190366888.b4-ty@konsulko.com>
Date: Tue, 08 Sep 2026 13:52:32 -0600
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

On Sun, 6 Sep 2026 22:13:40 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 75df64103873fac09642860cedadaffb8cf6b2c7:
> 
>   Merge patch series "Fix logic of OF_OMIT_DTB and remove useless dts files" (2026-09-03 16:12:28 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


