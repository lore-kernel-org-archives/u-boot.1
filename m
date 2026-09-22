Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED6FC98302
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51D9F406FB;
	Tue, 22 Sep 2026 16:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWrYeQptCJNZ; Tue, 22 Sep 2026 16:43:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6F13F406EC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790095416;
	b=njeCcb1mnN8IvBjCogJ80q/TQ4e9+9G/gc83MFmO3GQJ5tDj9wI142sgd7q34McRZMGT
	 IDIAfUSt6DpKWneUqkUuakvPPop5Jq7/MvH/qXhHYv1/Qxsw9afxcv+Gzy7TLZOe9nwZN
	 IYAhnknapcVAF/sm272KfPTmwGoXgmYKNRUAKRJ4BKarikgEexg4f1yeeTxBCgXtwtXdC
	 cCmkXW6zCOiEfkKq62Fc+9a2k9KMYjornTUZRnx2Cc9lr8qHQFvjQiArHINFfkja4acnO
	 WHVgvAXPHRO33UqRc2m8Nqv/Fo6lTNF11QjCV6proLBTCgqPs/Qu5WnZY79oYF863zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790095416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gMbn7ja+PnddPnfnqKuuZIAznwZQSBgO1dL3O0t1hyM=;
	b=K9EvAPWi4n3hiieEPRHIwM/OG69obA2GpYfGVfKqPK9EjBQ0+H95ytuQYemncxy/V4eG
	 Q5M0wL+dqR+6ut3IumtlG/2f8CRY4de2/5ux+QF5uqSlOsrPLzyhhv5jlT1gwRsvzyAev
	 c9xEBsa+B4IzpbeF2JSrv+IHX4AhZ3l5gkp78H4kUBU0Oh0dqogrtfxw0jI56ctXkZk/G
	 0sLijIBXB+PbBIPkowzfZyxaCI0Ug0s7e8WbAYrgBcINc+0v0ksZ6Wh6EgdVYImSYbnX3
	 WtqaHGovKSFGKrv+Xx6Ht0SXrUwqR0dfQZgiOCHSkOfqa7xUWQkRAEXzpa8tEdhzjsw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790095416;
	bh=gMbn7ja+PnddPnfnqKuuZIAznwZQSBgO1dL3O0t1hyM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FaO7GxXrjRZurEg+hwjdQnFweLoXiINO0s8onKesmczh82MNDJ5kFElye2QojI6V2
	 h6ueIw1C3y20aOAKzf4SzzflVrcVyuRh8aBTHNtA/tR6cVNCgmckW6ltxlMvkd3rlY
	 i5wUS0UGADrJT+pgMfEvDITQLN7uDaF2oESP8Up0JvnIg1DInitloPpYdbIRcPBvme
	 A89MRbmQf9hM2t63mZoXJ/Fh18Dol9CnRqpYJ9eWI/Tud41dXN0Jh4ixrwWwXAS/ud
	 y7uZymWw8+D7RrnIXrVy5DmYz/zpYxZ5YyI/gfzb8ApWnGqY5RgKoOIkEP3I6JEPQC
	 2yBbg6meKLr7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F13F406EC;
	Tue, 22 Sep 2026 16:43:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1338012C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED67A606C1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:43:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VskooNaWi1SW for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:43:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1B7956064C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790095413;
 b=JFyY88zwXCOonYdqPHBJbdkjxAh63da4oUL3I9mwcEeIcKYxumIUTsWWtwx1gQwamOBl
 1gscy10D+SerASCjTxVbvk4GR/rv7m0VNv+1qgP90uz33udgqpCLwV3d1D+cQcjMdNZVd
 lAuTGXNirgpb0nLPgIPWpF3bYJpx+c+x7oZAzdtImTNOwt4l8pYOWE+NSueRpGbuv6R+8
 +WgwCo+3NVLkvHx8HU1VzuM7D+n9j+c8OneUetjvXtYA9RhBTDrtTaY/MC0vZGsrdQrUY
 ozwFgy5E2Ef3TNjVatej+EgwH2QPLi3vNLsOLkwIznWA6e5bxhLAnqAHCxZTM4FcG0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790095413;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=gMbn7ja+PnddPnfnqKuuZIAznwZQSBgO1dL3O0t1hyM=;
 b=UQPW3/qLKDva1LE/rmHcPHxgX+ibs+d9aeL1JOYkgpfS+SXcP7Qt+RXGV3Bd97oKlHb7
 ZzUCn8ggecx418SiO4OFm3SfJ+OLHMJty208Mu6mXIBUxiBYbaUs7Dg4UcLurikQzfp+z
 DkNuctZ3lVDsq+SYUXh1Ifu8iaeDxxAjw5MaZjJlKy+kaAzo9Zta8uv0LTC5g2Hfkyh7z
 HZlAT9YJYUUc3y3Qn6abKe+HqvO+VtZ7BwHylTUGa8/KWi430eR8lRYwKMqw1UDbotjue
 wYOsGMLojGGJvTDxdjwHwFSpYRwWTlituYncBiDOEXWF9dzM5Q5TU/S0ENFElv+xzdw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PsrBlU5p; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PsrBlU5p
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B7956064C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:43:32 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-4c112aaaee4so42364b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790095411; x=1790700211;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gMbn7ja+PnddPnfnqKuuZIAznwZQSBgO1dL3O0t1hyM=;
 b=PsrBlU5precFxMn3NQ92liJTaz6iDJ2mZ7MW4GUR2oJTeOnkM2+t1Jr2bDGWs8t7xH
 ShFd1Ys5+Jh5W95rtL+dhoDaCCqQ13YuNWYh1HhR9sE3bWr1JqTAAzDG9Sh26nMVsmc9
 F5EwbxImo/L9E5P8HmGHawXp50qoy84pjbNUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095411; x=1790700211;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gMbn7ja+PnddPnfnqKuuZIAznwZQSBgO1dL3O0t1hyM=;
 b=cFT+FizFij0igVdiYbXNcIIhOcNokiPLvZjx9LgIfxVi/g0A/GLPuvinjgFvgYNSJO
 RZ3NUB8PXLWs4dow4AtQPaq/1EsHce/twRq+8bPoOsiGvF5+zNK8/1sdvB3HxbPLRiyV
 WuODynCcPzNBtSWJvD9S032ybt/rQLW8YanbUWHq0Ge27C0ZKL3m4PwV40I+X4t6oJ8p
 dwE1QoA1oq02CkSQycmYNd9x3fsn1S47Xp5B0Pz1ZJ+MtxKCibBnbFATrHxqkGxZJBKN
 z0+xkM3i/rtLomQUlCOaBiB+zV0x6zV5sP1DcdLExp9RYoKqReUgmhFoVsChlshW0oLP
 jDzA==
X-Gm-Message-State: AFuF++n/O03k4Uz7/ferlOQWt0/EraT0Oo8366ncPPAun4mlIeDtxIGh
 PtEbwIWWUSxIyibjTXCxdTXRPbA/sfG0poWsTVmgPfrCboxc38ge8WiFqJ+3PYTuBrg=
X-Gm-Gg: AYBFou1+7l0OWsM9IB/NtVw/5nz6Jdotn851jJ549T+4o+qOKEzSSlCs/wl/DmZb40v
 yspBuLwFfbB5Yie4X7Gd2DaB5SahPCIJ1VTh28P6y68nOf3JsfHorIJ1ZaD383M69P2rwPbemx/
 sW1rQK1PZNKLg5LNQ4ILZJ4ZE9wCExoQwjtg0qegJd+m8SnC5Fvso/wwDnvyNpudl/FjbDsvgU7
 roLEw5msg9/c+vxQ7/8ckdr1s6ZQ7gCivBLYmqHWHi47Av4K7XRcraBuXxeMtPKb84W0MQH65ic
 Zk9e8vBMYkvHq/wcN9NDV94x69LqCohWveoMeX4+Wwu22LZXYQkh/xexldwaO5oKNZxcxwevq6I
 mWWnM/Cooei/+Ujkj7RciS8J0KHw+RqzE1n/Dhl8zlgJ2tDrHpomjMMJnAz69J5n+7jR/iZHAaG
 U80dUveOjy+zQ+ozFEl7BE/XViivCjEdoJxqm6e7g+agRMFpNNmhgJwHiRD+AmbC/dRNuRFWain
 iY+CaUQU3l9U6nO29UKor+poHzId9hOy18kcVTc/z3gkBbHEtJuBRlNx7VSlDKRUt6jErca0Dnl
 C5V4YtWkrl/8q9FiFF5TT7+D3H/7
X-Received: by 2002:a05:6820:2224:b0:6be:31b7:e684 with SMTP id
 006d021491bc7-6d18e117f89mr2737676eaf.34.1790095411493; 
 Tue, 22 Sep 2026 09:43:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d1df5b01c8sm1748218eaf.15.2026.09.22.09.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 09:43:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <91f7a823-3822-4e2d-b44c-8d29e04277b7@foss.st.com>
References: <91f7a823-3822-4e2d-b44c-8d29e04277b7@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot next / v2027.01 =
 u-boot-stm32-20260922
Message-Id: <179009541088.667067.8097585192859872611.b4-ty@konsulko.com>
Date: Tue, 22 Sep 2026 10:43:30 -0600
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

On Tue, 22 Sep 2026 11:20:26 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related fixes for u-boot/next, v2027.01: u-boot-stm32_202609022
> 
> CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1352
> 
> Thanks
> 
> The following changes since commit 951132236b9adc592c2e49faadd103c6a355cac3:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


