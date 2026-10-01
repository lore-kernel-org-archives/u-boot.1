Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA28FCA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CEDA81138;
	Thu,  1 Oct 2026 21:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mK5l1byaFKsl; Thu,  1 Oct 2026 21:54:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BEE0181139
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790891670;
	b=NOiiwl/inyHJvgaptoYyAE7c3LfscsF5jiG8IELW8Xdrg4nQ3KqN3bpQ2jjI65e0Azrr
	 LYZcjO5MypL1zRV51BAD8H0ex8N/7kC/57Syj365lmtkQH5LFq0KJqnATI5XejSnY3z6a
	 tcieYbya3RmMABvBQMs/5xqIyVY++9WMH2CigoxgyVn1nrrky7KGz8wc1uIwmzhYuXq5C
	 3JQ0HayF2aR7MrpPreVwkz2Sl+ApRlVwAeassXZ5Z5R4pGZP3IQ8mPfcAARCYyBnocEY4
	 7QlPZX41hAyPkMgB7yr8GH5fO/fwmoa4YALrEFOW64A/Z6ECrI8v85pCL7GMrxsx7JA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790891670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZpC8OgKr6WS7EcCCPpZRnNItE0BiBmAww/8FVywnjmQ=;
	b=RmWyKuM/ylyz09IjBS6BYKMJDKYVB37cPBlGgZCtrqc8/bpYk1qQeI/pkb0EXm8sw/OJ
	 LpQei8lt18Rv3zqcgWo/lt2oXSA4gwNQZqblXNEKJ4xvTvPYG//gdk+SMPyXaJIMrM+aM
	 TvKEooTA7CBvhKwyIrPphByzOGnyfVj0KKxEGs6tUZK79Jv4jg39RjktUyJiQtHMjfSuz
	 6x/CwrMeCinCIWWmDqyiJXVs4ct7sIqlq3N5VAri3ZNeW4QfoG2COEVqP39dYGNSR6PFK
	 RfhZGEKgBy2jw3B9s2FiyNM71uoXVtgy91yClQjjKV8g+sh3b1KJ3LvRf50UZA/cIfA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790891670;
	bh=ZpC8OgKr6WS7EcCCPpZRnNItE0BiBmAww/8FVywnjmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KXixnOfvRKcFFXu96+foWyeyQ9unAfnj719seXyZcmIS6KxnN5rYIib6T3mc+JMaR
	 umCegoLZZhIaat0tgp16VTQeseBc9GmIeKU+BLysPkd9WOXnD9pv83QQxhjcEDnTsT
	 exGdYFwkbFQFii4MsRY7ctZeakRtOfJbXFhjg28aZdWVjXIitC9WZoT5TISH8eZFRJ
	 yDVn2yPoyrSbr5CnwfRRGFK9BcXZZYE3nqOMeHMjN1h/y6dcG+wdxNjlkourO8PGRQ
	 Ne64xFPgIJ79rZviTHyFQHYlm6kEBcIROQGDHDg7jwNICbjZ9RJDsUKfw4md9pwGqg
	 /t/1c19rusSNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEE0181139;
	Thu,  1 Oct 2026 21:54:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5564322B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 21:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE46540BF0
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 21:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 69achN4iajeb for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 21:54:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C7EDA40BE8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:38::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790891668;
 b=hnbsK5ly6JrvF7NJOsuvcbJqcnB1joTaeAozTD8qFXlq2lNZKKSaxceZAYwubkv5w8yS
 CDBNKQUXU65x+T6afzq8zlcg6qzeRHdlDZ9kxtyM3f9wOBrIMIwuV9/V0mu7s7DxsyFAU
 Dsemn9qPwaMtIUFvjqHboxR6yDKQzqFD6Obc0MuYh6VXeDgPsvWrtjF+0wZBUk8GbOJtN
 aun18Uejv7v4deD9z+1s5KkyX2Mj8YFX2AGE7puvlwZIl/G0pO9kE+tnnRHdtOSWtLrTo
 oTC53y6GIJzfMT1ieYCDaqjfAJr9DK5E1WbC0oiIa8p44Y+iOQrDKCKLzUPuYrpamhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790891668;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=ZpC8OgKr6WS7EcCCPpZRnNItE0BiBmAww/8FVywnjmQ=;
 b=WPxHgjjrpsDDrYzMfqP7G88ADN+cmkfQSWcvQjnrJaDH8+16gmMguXgS0kTBTH94xXWT
 Oi2dEeyD0xpx5MwOij82SjNSz0TBBOpTgDlnuzAWFXXbAjen9BlArbLCC6jvbV7ps+W9j
 dRjodK5/QTXxlTyvmZj2elomk4L0WDVGJ1RAEoPSahcM7WnnTahUGrjjAKSiJ4AUV4SEl
 wts2iJQPa+kLBAC/W4icaNJGDlcLBOov9Z8YMzuHrFrvQkif0m4oSiN/X+65jKx0qXi/V
 zFWzEdU6raod5ETwkZ8sJIEk0KQ31r+F//2t8Uv6ni6d217Swr7km0L2xw+3qn84KwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hwdeHhtW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:38::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:38::d;
 helo=mail-lr2-x0d.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hwdeHhtW
Received: from mail-lr2-x0d.google.com (mail-lr2-x0d.google.com
 [IPv6:2a00:1450:4864:38::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7EDA40BE8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 21:54:27 +0000 (UTC)
Received: by mail-lr2-x0d.google.com with SMTP id
 38308e7fff4ca-3a881d2e66cso1708091fa.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 14:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790891665; cv=none;
 d=google.com; s=arc-20260327;
 b=Lb5MOOHZq5R4MsaaygaGhoKy3kM9L40GfkRRaecLM57otJ74XCvGSjS4+OvNq80ryp
 PfZv1w+VDU307191iFHMbB3yNWBYTpXyXmtB22slqc9i+9csyzG6Jn4mzElttwMFMdRM
 yjhyxjAvu6ykOqsoIiQTCL4OyZFMDGSEPsdjRrqe7KJBb9mYBA4MbUBHYMpajnRuXwyF
 u7yUVd2ZtdsBvvDssgM9ed+/PVTAazekcgQSFxdLSlCNRLDRtzf6bSImSuF5Hcq7E4r4
 VMfMx14CSj+8rB2k+lQ6sy6IYbtVk4qSYBCJEEYNnmYEYA0XfRo5OsRKkYCH1Ph5zmI8
 0asA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZpC8OgKr6WS7EcCCPpZRnNItE0BiBmAww/8FVywnjmQ=;
 fh=tXq3xWMh9Qs5w+VCJzO273L7HyIpBiaT/XiDZReOa6A=;
 b=nGWlSQWJkNISlE1SnN8nsyDVrbrr/7cihMBL2xHgIMfpDFLj3zTVaQ9GZ/slzGL8ml
 +HxFcahY3sy0gavKX+ZgPzf/Vlo8ObTVQryrM3Qdj9s8l378HxurUc+Or3x52yOgcrlI
 qZqKMZfO0Cz4kXQ2FNOdCAc7YY9l061c22p8A4OFzlC7+WIC9IORlCFJTRWsDC2gqcnZ
 1ZgYrA653DyHj4CpX0kTLjqcuwrO9dpJ3TtqlQpCFAN/KgU+Tjy7nQ+1zQHlMKFEILWH
 XzVdlD7jf8lkgL5K1jujtoYHCHvOClUu4hB2hSqzms+LquTEI87jMnQXuHhCUwCPHpui
 fyOg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790891665; x=1791496465;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZpC8OgKr6WS7EcCCPpZRnNItE0BiBmAww/8FVywnjmQ=;
 b=hwdeHhtW37Lrk+5rrcMbN7FBIqObK7MwE9gy6G6EquwCXMq2Jm9nhqzw3ct4s0vYcP
 WERuJvgtllR5qQU7aagUxXd8LMPZ3g2rLWLnb/u8SkpKvzZlKzqguPSRs1RSCm7xQJtV
 vUMvyXHcfGQoF1xYNGf0z/3KNr9Aj1KusFfFTJoikboq5rAgAg7F8ldkWM4c/MSpFoks
 eUR9xGBVAkvQHl0zcSqIkFxjQRrI6VLGTo7jdakZIqAQP6U6l5Dxs/gBy4RbRQT9Px0v
 F/HhifhkgQuOwee8+92pyCsegyKwejuh5SUfPdttYHLBstd5KYO8kiCty1DFnjoeB6Zq
 yxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790891665; x=1791496465;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZpC8OgKr6WS7EcCCPpZRnNItE0BiBmAww/8FVywnjmQ=;
 b=YU7NCebXGosxdQhev8PQRJ6zKW17kLjP61OxxJ+AdqdghEJward2K9akR82c1EYm/O
 by1O3m/h2u8LemJVEA3Q8rCzP+6ZdHWKiWmsycqBI4PUMkL7056nJsk3HNRpatEuqqFS
 p7I0YpMsb3URi47FfncOgj8jOQPesP/uNwOIDfTQiOIyH7gF1sL3GmZYQTaeqWhD9zcH
 7C084wdidRCn4vmeRQd+ZEFnzIPxzVpwO5MlTjVL+nFdsKQW3H5SftXVlmG+func/4La
 o8kul4O+gbi5zqjep9QnYnR1CCnEuOBU4JTtUcQ1Upmau86SVqeTBGRhs1qosSAzNI6M
 6u4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpDmcv8iBULHzY3dxVSEkiYsKCQB5PxJH6swinE3uckaA4gpVryfWnXStRlF23gwsbi93GUvs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIBblex9bnKq7T9ZTj6lULx1AZ4jMOte5DtoffEVDiDideVACnr
 8XxX+TQKepQdjQJTxOtiI1u0LDV/JSXeigGCKXJrXyAdlXPJ0OIRGmUp7m/wpttQixkOaPc+VUn
 /BmviK6Gf+So3XslN4mQbdd1eOdNYi3oKvA==
X-Gm-Gg: AYBFou0zHNzgVt0SITtCM9OnfZnY7USIIgpSQWhDrUL3ETNHjamr7VSY23zpm0lhzK/
 nzDgpMIKfL4lhN9mkVMAzXgk6+FDTPnDgNY+af9Gs8oUvgv5mwDpYQ4adaXalY5Ptkr27jd3xc+
 0jkBrbemH9RbbQd79hdt0zx6ITApGfgN5Fk6QDd/dR32n5bB7kNce1mEn2jfj6VHW6873cGIp4E
 FM3RiohGUoVYFlfn3NpsOMC6rj5+7vFDy5jC0WJAVwtMbTX9UlUu6xyq005qbMkAQoA3B82wpxO
 K1gft8+9Jt7B7vMwp6nNmmcaDJbCDkUBvjWcsv3/PPASAJDbGObtHN/FaYzw7HVvWiFgrNZGuqX
 oD4jtCttLU7++ioQpkVBfRJ+6Wnp6ki9BvxrQKOYuVgjU
X-Received: by 2002:a05:6512:3052:b0:5ba:3c5e:2b20 with SMTP id
 2adb3069b0e04-5bb9bb203b9mr182027e87.29.1790891664690; Thu, 01 Oct 2026
 14:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260930155239.7091-1-stefano.manni@gmail.com>
 <20260930155239.7091-3-stefano.manni@gmail.com>
In-Reply-To: <20260930155239.7091-3-stefano.manni@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 1 Oct 2026 18:54:13 -0300
X-Gm-Features: AclHuK8HVbN0Fpzr_j4QyjoZGw1Bm9fdQrRdnqpgbTEsZ46v06PWEkvfdePf_qU
Message-ID: <CAOMZO5BkEHkRVSAtkcOEBuO7sZnj1_fYXDCosJbv=j5SBVnraA@mail.gmail.com>
Subject: Re: [PATCH 2/2] wdog: add i.MX system controller watchdog support
To: Stefano Manni <stefano.manni@gmail.com>
Cc: stefan.roese@mailbox.org, sbabic@nabladev.com, uboot-imx@nxp.com, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Stefano,

[Added the new U-Boot mailing list address]

On Wed, Sep 30, 2026 at 12:53=E2=80=AFPM Stefano Manni <stefano.manni@gmail=
.com> wrote:
>
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and watchdog etc..
>
> This patch adds i.MX system controller watchdog driver support,

Nit: Please avoid writing "This patch adds...".

Use imperative mood instead: "Add i.MX system controller watchdog...".

Also, it would be better to squash the two patches into a single one.

Please also add a user for this driver; otherwise, it's just dead code.

Thanks
