Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF7606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RWubxP2l;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rJqoJs2H
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19F2960614;
	Sun, 22 Nov 2026 18:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bobnUw7b1mem; Sun, 22 Nov 2026 18:36:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 105056060B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795372565;
	b=djWE3o24lyfoPtg/+LRQIWyvADuuE4jLOmFVnvEfvNBULJJD2mNG1/2Tb12ROwF1rEhd
	 n+O8HuQbnqw1gJhaIXWgGY6tKVb6EeIyfrT8QW9UNSGsFfMdAKYdeIHiXOciswnYjfhCw
	 JDadT1gPRTQchIt5vBV9NPhIBPL748Hbd1QAInCr/NXo3IqIjbC/QeVfR24wA34d/8Cwb
	 TMDj4zt5yci4W3Cr6Jn0wixak10UrtgxOrgKnRr6Oj2dVobBTYhX2+fWEx1WfZczhuqgo
	 mvd7te8IAI86ixLcabzDUJowpdN/ZjgqwU6xOR4J9THsLAYz+9icwbyUcyfhyeCe3uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795372565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mqiIqlaq5hhxEyqIWm3QzCRmvKnXOKdbUPtoJq9z1AA=;
	b=EeuouYsGcebCAlyrdFdAz9xZPCDLVWy9/QXQwgMlriOGV2FYQD1jnh6kI5g6P5Y57at4
	 7y7JIln8zrVAmr4wXZONOWjs50DD8Lr+EYyrL+gKnJSwGcq7CloGlXbJ5kQ0L05YcenUO
	 An7tRNaIJ0WG68CjFMROISQWZ7BdJEchsybR8lSGi9BX0H9QbDQy5Lz/TdtAT0Wd8QtNP
	 jmhKxoHYaxf81SY9t0PjJutSbFJoZPqy+XkeZJuuiDZT7WbdLO/sGBRDxtkwXHFjdacZd
	 WmiHwWOaLrLVrWm7GOoIXrzVanV2YgYX5uSDWDytKLFQ5Uj/rHkh08esPPZSwznDnZQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795372565;
	bh=mqiIqlaq5hhxEyqIWm3QzCRmvKnXOKdbUPtoJq9z1AA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RWubxP2lv3pVW3DXUNSz2227dt9m5yqGY4BrBffLmf7uo5rjR6S2M2sBDHF1qfOy1
	 3Jw3hd55CQbtYqkl6DzRS+v3gZ+QPyfbyqxi41GyDkdnCAuoV3Tbp1LqjxNPplI2gH
	 ZdqYfdp2bsSIbH+r+urB0N7RWETaYfNLuSH7wfUE9rQ2N9hleOaTqcaQN78ZakYhPs
	 yAuYTBtYZeY8BuTBmisDii3Bd5N+EOWdKTwmngC18Z4N/Uwzth/VBOaBTvmQvUHsnK
	 JsqlWjBXQp1Jb+fPXeLVg0wer7PM1rhdk5LK9HRwJc0Actx4S+pPpSIL/VYFVbvSRU
	 k9nLnHD1CBD9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 105056060B;
	Sun, 22 Nov 2026 18:36:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 299C0371
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 18:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26E28400BB
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 18:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C1LS_IPBm281 for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 18:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 14FCD400AC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::132a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=rJqoJs2H
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14FCD400AC
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 18:36:01 +0000 (UTC)
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-38431138772so3330659eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795372561; x=1795977361;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mqiIqlaq5hhxEyqIWm3QzCRmvKnXOKdbUPtoJq9z1AA=;
 b=rJqoJs2HeISn/N8OAYcrlai/2GiyqK+3L5nAXlAWpzyN+P4CN3ViCP+WsGU6uRv5D3
 dghfrU+FuPkqj8I99fw2z1tVsSlFB/mPNLg8f+K4rOxnpasZCBP6N+aJ75o50FfPqpwJ
 zi6EGWq/eIHDbPVswxs368epX7ZkD0AEWpIngMIhKK7tFb1DctOZTNFtO2514sfrA8iI
 ObtojtiIpF2Jw533nX+UXwwnDYq830rzfUdwPu6VtkwBC/NRQsx/xbRGWjAz0llU9q/4
 4c/PA7RDoFkKGc7GqjSAX1m2f1Lfh8mxidn/9gMN/CF+y9JXIFebFrSe8i7FnS5+uCJp
 DkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795372561; x=1795977361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mqiIqlaq5hhxEyqIWm3QzCRmvKnXOKdbUPtoJq9z1AA=;
 b=v0MClXSynwzaejnhDmXDfBYoFM57rE8SI1mDGOZHpe+GWMQmyu1WRDer6MuaFtL4lf
 8PiH9I0/NZHyDuBpfuoWy4iKsVQy7LCl7Xma0rZzE9UDhUP4Bw9iXbFRjKqnhiB3LKqo
 ydlJB0eJZiyMxvdVr8F+ACOITZNQQVOu+JNWZ97M5zs26HjwPR7QJc3TqK9EpLGv6F6S
 tBcSAoEuURE9u6CxOVpjQIks5uIk9X0jiI6AsG9EQ5fHZIJ4BLXJKnhD6bCuN+iw4Mut
 zRrvUl6xdcrYEoFkiqu1AjJvGsigPYwD3TH73MRBh5AO38uxsAHl5kHm53G3f3bepXjB
 b0NQ==
X-Gm-Message-State: APuU4Z+xEnVw7OkWSDH8SbRNqvY9d3yWBUD18wajE3p4DkiNEdR9RqnH
 R8sFU3NqorwJps7YmVFu6Imrg35QnzWtZgsJJGd/QvJ1QfnSCZKuq+XVvRs0QI0ZJD4gvWH1EyV
 4n3uHo3OvKpsK0ID6+DZeYdjkEuiIzwk=
X-Gm-Gg: AZFdTZfAhpVE3hInXDMH04Nq8Y6/WCYPkMAUH7bGxWIO0eLBKLmxI6I5/Ot0JxvhMMQ
 S1eOWptazTgGKjHKeMHT2WBV6xfIdIUuaUQ+F+ha2AZOF2sAiiW4mpmFCkPoMYsG82Um5k+tKal
 Rmfary9ufejccRQ8PTRJRFx8Y8sjHuYSxVYoDLjBdnZec5Dwn+fvEfUVdPNXtowOS3ZCosgj4+R
 a0Qf59vbDWiuLhJLH9FW+Q0qPbH0fsDtUz36GlORjt52tjfQcxE/iukJ1C2Fek34565F5D/QYy+
 MTCF5ceJ4oLgVQMFD3F21/RST5/JrGyLCQc0zRH9GXODICHnt/9oFsiUWL4DurSH7q43uRd1XwC
 eriEBDiaYZ9qB/dyohmG0cG675ydVfub8vUXNgdYyFupDKPkdOdpSxKM+KyZKiS9vy+ach81lJF
 Klun22ilNDrxQRC3/3BVDedvJv/JPYFw==
X-Received: by 2002:a05:7300:3c92:b0:385:b3fd:dc10 with SMTP id
 5a478bee46e88-385b3fde0f0mr8722912eec.30.1795372560896; Sun, 22 Nov 2026
 10:36:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122-surface-rt-en1-vddctrl-v1-1-2e60fd8db38b@proton.me>
In-Reply-To: <20261122-surface-rt-en1-vddctrl-v1-1-2e60fd8db38b@proton.me>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 22 Nov 2026 20:35:49 +0200
X-Gm-Features: Aa3M54qA63QwvqcW3DKeCIPyE7F5jZpjzX1VXC781pUJBNTHqelHjYo_mG5Lf6Y
Message-ID: <CAPVz0n0XFct2MXN7njVwgMdryWgfU3rzGDp8H6g4KFkE4QM2-Q@mail.gmail.com>
Subject: Re: [PATCH] board: microsoft: surface-rt: clear VDDCTRL EN1
 assignment before enabling VDD_CPU
To: jerome.berclaz@proton.me
Cc: u-boot@lists.u-boot-project.org, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BD=D0=B4, 22 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18:4=
4 Jerome Berclaz via B4 Relay
<devnull+jerome.berclaz.proton.me@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Jerome Berclaz <jerome.berclaz@proton.me>
>
> Linux's tps65910 regulator driver assigns the CPU rail (TPS65911 VDDCTRL)
> to the EN1 input, which is driven by the Tegra CPU_PWR_REQ signal, with a
> 0 V sleep voltage. A PMC warm reset (PMC_CNTRL MAIN_RST, used for example
> to reboot into RCM) does not reset the PMIC, so U-Boot and the next kerne=
l
> start with that assignment still active instead of the cold boot state.
> About half of such boots then hung right after "Starting kernel...", with
> no output from the kernel.
>
> Clear EN1_SMPS_ASS before setting up VDD_CPU, so every boot starts from
> the same PMIC state as a cold boot. Linux assigns the external controls
> again when the regulator driver probes. The SPL I2C helper can only write=
,
> so the whole register is cleared; on the Surface RT only VDDCTRL is
> assigned to EN1.
>
> Tested on a Surface RT: 6 consecutive PMC warm-reset boots with U-Boot
> loaded over RCM all reached userspace (about half hung before), and LP1
> suspend still works afterwards. Normal reboots go through the PMIC restar=
t
> handler and were not affected.
>
> The problem was investigated, and this change and its description written=
,
> with the help of an AI coding assistant (Claude); I reviewed the change a=
nd
> tested it on my device as described above.
>
> Signed-off-by: Jerome Berclaz <jerome.berclaz@proton.me>
> ---
> Sent here as suggested on the libre-tegra tracker:
> https://codeberg.org/libre-tegra/u-boot/pulls/8
> ---
>  board/microsoft/surface-rt/surface-rt-spl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/board/microsoft/surface-rt/surface-rt-spl.c b/board/microsof=
t/surface-rt/surface-rt-spl.c
> index f327a80ef..7a8c38395 100644
> --- a/board/microsoft/surface-rt/surface-rt-spl.c
> +++ b/board/microsoft/surface-rt/surface-rt-spl.c
> @@ -18,6 +18,8 @@
>  #define TPS65911_VDDCTRL_SR_REG                0x27
>  #define TPS65911_VDDCTRL_OP_DATA       (0x2400 | TPS65911_VDDCTRL_OP_REG=
)
>  #define TPS65911_VDDCTRL_SR_DATA       (0x0100 | TPS65911_VDDCTRL_SR_REG=
)
> +#define TPS65911_EN1_SMPS_ASS_REG      0x46
> +#define TPS65911_EN1_SMPS_ASS_DATA     (0x0000 | TPS65911_EN1_SMPS_ASS_R=
EG)
>
>  #define TPS62361B_I2C_ADDR             (0x60 << 1)
>  #define TPS62361B_SET3_REG             0x03
> @@ -30,6 +32,14 @@ void pmic_enable_cpu_vdd(void)
>
>         udelay(1000);
>
> +       /*
> +        * Linux assigns VDDCTRL to the EN1 input (CPU_PWR_REQ) with a 0 =
V
> +        * sleep voltage. A PMC warm reset does not reset the PMIC, so dr=
op
> +        * that assignment to start from the same state as a cold boot.
> +        */
> +       tegra_i2c_ll_write(TPS65911_I2C_ADDR, TPS65911_EN1_SMPS_ASS_DATA)=
;
> +       udelay(1000);
> +
>         /*
>          * Bring up CPU VDD via the TPS65911x PMIC on the DVC I2C bus.
>          * First set VDD to 1.0125V, then enable the VDD regulator.
>
> ---
> base-commit: e578056c766d653270b14557c2a9d8daec414c17
> change-id: 20261122-surface-rt-en1-vddctrl-9a383020da62
>
> Best regards,
> --
> Jerome Berclaz <jerome.berclaz@proton.me>
>

Hello Jerome! LGTM.

Applied to u-boot-tegra/staging, thank you!
