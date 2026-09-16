Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC5DC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ABCF80E44;
	Wed, 16 Sep 2026 13:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rSSCqzE7ANK1; Wed, 16 Sep 2026 13:08:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4D38E80E02
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564114;
	b=UL+MMfBX2zqaQIq9aXuTVZN2BPSO+pWX141iuZxfjgC8d7CLC2xQV7YsTc4N7w9k9lFB
	 8Sopy9qk32xx+Ax8Vdd+PDETR0ZPDo0D03cuLniWJ8aH61HA29j48MRga1AHdep0AcxHt
	 W343xDsue4vohyh2Pnr48f5sXBBtECYl77YfU1+9Fvs0LUjr7uMHhGy/+/S6VCNKkc28d
	 L3BxPecr7lKk8trm/h7bgAHrduyVgdyMSKN5hOMptxlAg5rk2r2r7BnB9SH28OYsFJhIN
	 sXywvgchAIeN3CkqKAEwiUJugo+Qv33v6JyUpjKT6jkp5aeJ5y7I93+/R4fXbBZHUlw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EpnwkoBBTkYiRLFDxiWUOgV74L1nbPXralcqo6yFJS8=;
	b=pWHAp0Zhgy+0wMgh9oUGuD8AhCkB/Dq/8jfzBn72SFYW+rYEpw/Apsq8HZKlijGX6jgv
	 U/0SB8XESg+aumu9jPdCuRfsWoFk85GMO6rl2XFaiGQP5fmgvnAh7Fnonmq58RWsH+ca0
	 QW9XbD02gMzKjirgjojv3J3XaQkGzsNdaGDqBnE/4dsDK1IWoQh+FTUZON3yEtLEGGEuY
	 NF+j9TdVzIJTixPmsJUFr2mtiMd0r4TF6FcNp3eYBuuZOFq4mkFEB/QpSEYWGTqtz5o09
	 7xmCJ8OuiO28HlOzsHqZzM70CNALspE3YhLvn3kQxCZDs8f9UdA260t+WCHRdveVsng==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W639oFWs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564114;
	bh=EpnwkoBBTkYiRLFDxiWUOgV74L1nbPXralcqo6yFJS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1C7WG7AeacnZmzypi5NTe2Se9U3XahDVXVqSxTDbpeGbd6B9vtsSk9wnxvAyzTxj0
	 5SD4kkVHQF5STDorn2PlQCSXBEIOvYV0gAy8p0rc4CzsJW0JP+DSmv8qMB/H1G/0Kn
	 POhNWEsQAlORQv3HjgAOWqwAkY462Gq5MIUw/3NDHBUzkW5JM7CELqBdOETfXpSaSE
	 RpoWiYY9shJSOYRkDg+xncaloVhTkkySjQmKyiDBPiXgALQEpMypqlf6VnRg7Wb9Kc
	 KXyPoIWeXay5wkm04UBnMh5xaGGC/bfRlP/xE+0jheYxTR0LKX+4H6Fl5OF/80vH8+
	 8lb+o6MnhX/fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D38E80E02;
	Wed, 16 Sep 2026 13:08:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A81152E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 996F980857
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vFkIZQQdb50c for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:22:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2405B807F2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789561334;
 b=DdPacH89dosdIuX93dfqUT/6Ml4qjOIJu8KHaYaEVGhXI1j80rIQSHEuWZ5g/V7vhAeG
 u8xMDZdEMZyS+NtQAnaA37DckGpyC0vaF5WXY6zrw/jS23k9NdPo86LMMsgdRh+Q1sWDN
 mbBAcPem8ZANipAjgbttwZ9BrloVv/7notZMTi/dz9YBcYm1fTuxbmYwe/Ih0hJJCWhyG
 8OEQt1uhv2OAlhAmwXq7WMY4TkamJ26md8VwozJj90hLUfFaVIywuxknrHG+2kx7u76hk
 WnOIavJWh0zGPZqQzkZymwQcgBKlupL1SD/bMJBJnYnwZH5BtYS7VpWlcDe5KmY+V5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789561334;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=EpnwkoBBTkYiRLFDxiWUOgV74L1nbPXralcqo6yFJS8=;
 b=W/hcLcvgCf8joFG2NqQlW4419X/tuL7JW3uET6/7MW/pPNCubGSbt/V3mN8nF/EszZPO
 eHHffys0lWmN25SGlP7jwQKljbTBcj3UVe/4i+lIIb1Di9+D9lwiwYCTBVSoBQADwlmGi
 +xAWqulx74NezLGF2LgMGmq+JKpqflytFPxS8zpJcF9sZBpZ4bT83pCbF7Ikz7GeBLJXo
 h2pXbLMsao+MfrMIM9X2ILcym7PjzDQ0fSr4uT7qlr/Fxk5ZhaoJj4UnkLTWx8AW+4EUL
 Wo/jKN1rg4nDAO4DYbetMAP0NTD9V+muscrNw64MujjuiQXo+BILm0wsNSWbmAVBXyw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=W639oFWs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=W639oFWs
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2405B807F2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:22:13 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a5d8ff62dcso116230a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789561331; cv=none;
 d=google.com; s=arc-20260327;
 b=DEgDGkL8vRWl2k2eXvLkigKt1LDwP576xF6yIMAco+XNU2O8CG1d8WPFtXLz5UlPpK
 VNVBVHqeAuIBgETVG3pzx9SIVkNJN68UA9BkOT3qHlehACycDh9rt6ltxqr1PJE2leud
 +9BB+H1+fiE1lGP91ptNsB/su9AV05hac7ut80rM/eVFPrLdbjKzDMjjWDUstBLafTAR
 zFbBtRz0avFAojYcsLdeu2hmdstMfmBv2CbA2h5tIRRhOSMfwk6aYYelZ1UlHbJpQkHt
 VjoR9gbvnACmupQ7qQ5K7BU7VmYMxxbVqvB+lr5TWVAEwESl2EW7U4fY5Tip1NpsOfuR
 V5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EpnwkoBBTkYiRLFDxiWUOgV74L1nbPXralcqo6yFJS8=;
 fh=wHmJqPHw1VSaqGt/o+uqXO2m7Zm6dclM9ayZUtWF+FU=;
 b=i3ml5EJtOkL6phZxKvYR6vYufBBX5WfUKMIC8hsrILOiBah5S14LvbCMzvIkkSXzUg
 iCRmJR6a8g35U8FG8RRrZMsCtRx9znyYXSm9unloUdWUglIyS1mDN2tUeFGt9XRqn0/u
 kxWQIAMQg8zgRSfl7DIcF1HUSx1tF4egDJqoBNKSZNZxB3Y/mu8Qs9cfz8Z97zFkKi5w
 uQ/z1/881c3PPisrpq0R8TnQusqLPqvZ5eebN0GuArkmgfwO6YIKNASzGPkHEGevgjG9
 +VXCaBKPaQ4ahMtb2z8a40prDxB53AAUJfowogyXVXgHdDCbQPp7cNqLJRUIIMOCjwiL
 pI/A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789561331; x=1790166131;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EpnwkoBBTkYiRLFDxiWUOgV74L1nbPXralcqo6yFJS8=;
 b=W639oFWsrbCbjDNj/7RcEBAUIkMumLOOETW+7EeTBgjpZOm46hwcuy3KDBAA47IY/F
 27sCS6CutTnBrBxedFqzKTHD3GkRAEzr2vcKnmnGGciYdR7v7wYxo7lXFSiESmXIY4qZ
 7No+dHkHJgAck8/UpQ1xJq0sG3VoKqhY//WJcMus5sFU5To82HPo2JQ2GaGXEC+D+S1P
 xIf9vgUibL2b9V6R6QRcceXWGsyC9AWqEYfH5epE7ZbT3rULNPf8z7tvwcFfPwXLaOCK
 v5xf41oyQOd9MvT8jr3eyoVbkYqU2OeHNSKjrWv7StFz3Yedcufwyu0u5bRcW6pC0D6T
 ESVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789561331; x=1790166131;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EpnwkoBBTkYiRLFDxiWUOgV74L1nbPXralcqo6yFJS8=;
 b=G1rS3EydppX6QbZjcyrfZ2tKzqBGwrtIDMaV+TeE7CZgHflu+FZGE08DMIwIFKcKj4
 YxgYJVnsblbXQY5X9EWwOdY9nQ3rCIKtLODD+JLX8U7SoI1OYKn01ZF9lT0TB86qeE5l
 QGotAiCSw91gIG8FxK+8V/KCxlt5m9NIZnmzRCL8qtUIHTD1Mwpgzb2iWSu0bjEGow4h
 8H+m7XCZk8pP53eJVrJ/L4su0IM74mlu2pcV6QlLeRFrPAZD5KySS2xhLVJxhSuL7riw
 AU7y87e/+HSnXc5YByZnwux0BWxTlRBsFjgg5YgHsBX9hZCbBy4mqq/1nMR3NVWarWgB
 GbGA==
X-Gm-Message-State: AFuF++nlPPDUL+x6WcCMEL7/tm4wjoQK1w/aQnsqH6KwonCNf1NTRfq6
 gX+DaLtlM2Ta4AfUmbmeCfTiwK02T76UT9RmcDCCrESqHXq+0zOUgn6PvlEbITNOoACZJv9xuAJ
 usrqmZUhmtP5DEdNcRbqDOERQunXB5NeaM39JflQ6yg==
X-Gm-Gg: AYBFou1H8BbrygaqL7aVPc2c1S1STJO8YhOA16LyKiQu8PPlBrAxtx5bn7BMv+Ieris
 IY8XXgTwtupxs9av5RytghYU2r6xiG60uvxYBTRoe14EErzK4y/FjZnfwExPIYRtlnOMG0ZT6j0
 qYNKqAlAm+hrw9TltWujZB5VnwmY70qPPDYD8XkntlyYh7033V7dsPACfRUnt0tZpGRuWuG0nk1
 sUGJaqQPGplOngHTIT24lTsdZeflbFg9JIXHSm8DHInZkhALLE2wYkkOqHGwvEtc31wpFcuHU5t
 NIjsTfElBwGr1udCLfzVaMTMIq5FW//8uLM4Xgny7f7FtqMEyr6GaMIwYg+DqckA
X-Received: by 2002:a05:6402:3215:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6aa2245a5e9mr2199129a12.2.1789561330891; Wed, 16 Sep 2026
 05:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
 <590ebda6-c1b4-40bf-a48e-f872929ba699@mailbox.org>
In-Reply-To: <590ebda6-c1b4-40bf-a48e-f872929ba699@mailbox.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 16 Sep 2026 14:21:59 +0200
X-Gm-Features: AcwNN1WXCGEDo2QIQE9R6zhQletyC3Zn7BFJMZWKIsJoTZottOWeYS6UyTPRBaw
Message-ID: <CADYN=9+qEg=By2Rc3kG3Aqk7YrK4ToB1VK1j_RJcjP7MDdEAwg@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] usb: dwc3: part 2, make the resynced code work
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de, 
 alchark@flipper.net, jerome.forissier@arm.com, dlechner@baylibre.com, 
 anshuld@ti.com, sjg@chromium.org, Thinh.Nguyen@synopsys.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

On Wed, 9 Sept 2026 at 20:27, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 9/9/26 10:49 AM, Anders Roxell wrote:
>
> Hi,
>
> > This is part two of two. It applies on top of part one [5], which resets
> > the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
> > the build for every board that enables DWC3. This part adds back the
> > U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
> > builds and the gadget works again. It builds on Jerome's work [2].
>
> This does not seem to pass CI:
>
> https://git.u-boot-project.org/u-boot/custodians/u-boot-usb/-/jobs/87618

Thanks, the x86 failure was a missing wmb() on x86, that is fixed in v9.

Cheers,
Anders
