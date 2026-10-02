Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C412CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 11:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF18260851;
	Fri,  2 Oct 2026 11:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ze2pw841coB2; Fri,  2 Oct 2026 11:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 94217607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790939701;
	b=rm0Kgg0qdkzChxcVKxapSSuTobOZ33tF1lg2M0mud2EqwnUq8t/+0JcWf3byQEctb7Ve
	 wa43jg/xQS+Kr8QwLCDjWq9JAhgnCaQBcIOyAOsqzb7fDk14kkibN3pH4LxNmyeoVlxXk
	 SMOzilJpphSg3hCQoF2Cjy9bbLlMEOSs9Q8loNPLlu2guHlRuClooGLba2kNar5gSK4zO
	 BMWKL916U73hfFed/5HPKzp9zh4BhB/yctk3Ff6bihuxQLIjRrK610FFYUDoVe+GGWKhW
	 0X61ej8Q9g/g0Zp5YRt0i2UHZwd/dxKu5vLsX9D9RCWnHHWuZh2N7+r8rxGsRUvLH/A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790939701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mebiGyAk41ES4sVvYNmR3ybkITFxnN8sgTl4zi/+78s=;
	b=KJVHVaiVrm0oTd7HSO6aoYWmxR4Ys4qWMGbPm/pwBUDZ85qTK/iwpSkvUinzknxyhFXk
	 hthQbM8OcWiXL/rudd7F42pC0rtPGMFsHjuC4KPxJxVZ5BOOpoemSMK1sLcyOZohTSW8x
	 RMB6xuKDphmNTInfuhNW9scaWxLex2yYPChjb3JMQZ8/gha3yYR/D6FNSx6v6vTk+DRGm
	 CAONHXdyhUrL+Ke5C78cCiThinI83JShnMj7znO4Qf504XFy4vEWGqL2ncT0QfJiKeIpY
	 lGAD0b5sTsBZyRkG10MNksOSXOrzlXRd1DhOYr2jCIUMuXPh6vqRwlJ7XDb5MImC0vA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790939701;
	bh=mebiGyAk41ES4sVvYNmR3ybkITFxnN8sgTl4zi/+78s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v3uUPIa+DbwE71N58vO4GVWZJSD+ftbphfbbOa9RqCAPqKWYANb8/w61jsuhiVGqS
	 639S0gS52bYImY2d4jWUkv4lZfrNdxM7c0mtllk2+d9vRGvPkZ3SjEKfB2T1RzvWBd
	 KQQV/pYjDfLPtPLDO29moZuZ6a/cyX+6OQObWrawKdxQgygGEHX7XSUXRnHoNhq4s9
	 n8Sw+jJ664duRwT+eM/+IPSiQEyOHIHCoOJMAA2G+C3A3TAsIFMR4CyJOmOeGSEVvY
	 QoQjg0kCNSxJffwEHtgF7bL0Hc9x2wI74pxGpKPeiuVt/zC6YPaMxhmg7VxusxWy9g
	 +aXKqcrzCtA7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94217607FF;
	Fri,  2 Oct 2026 11:15:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D7A234D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E9B0811F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GOYCIKTiQswM for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 11:14:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1F2B8811EA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790939699;
 b=XaQ/luegNLJCkZvRBYVDzPOISDjihTBoaUZI1qOWAvLrrH+rcPxxmr73/Qt8vB54FjbX
 F0U7DZ8iQ4b3jNJHx2s0yHj/b9o24ktd+oNHMbPfGiYfLCaIi/Emr/izoAVdbZ7cz+qYR
 GRh9EfD+u8FVY6F8WlQvFPOFSuT/KwRSZKDhltVDAq1AYJAWx6KcfvZcTDJc3uC25BjQ8
 KCSHwQCCTpP+Cj3eD4qFu2mcOt9CIDQfzfUiE302Tlj6CZNena/NPScbXj/R5Z3B9f4ke
 uqWzfekDwlirLNepONPVO7uq+jQx5/Pd8pwNSoWumgrpfkYyQaRbNsw/7Fa8iJxkpHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790939699;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=mebiGyAk41ES4sVvYNmR3ybkITFxnN8sgTl4zi/+78s=;
 b=ZwDOvOWI//IaTysG7sruTigp1X4sUAgRF555RaZ9/QvFpuvOhxvJ8RMIqnt2N3K/OQG6
 uzZK28zRoxGEwGWj2QdaCzDqsPNawZM3y1T9zJRCZNc8cY7/Hvf7vATeOmLl6HParIOL2
 pGf1Hz6DA0oKjEPTRUYmc+nJZCvWhwbBjF25RTtL3L5/tlrpdoz2jqvkkVJGxy3Ap/9OK
 OdSA8BsyeZHKTf1MmJ9YO+Wv6+k7eFi49hWgqHg4SyiSqFQpBcBoWbeCYu8Ul7G2oJOtJ
 F1WnI+GGO2HShUNEG4TfrIN/aaCxsESwzZjADoiVJgaSr4R/ZorjMtUWGnKLriaIZhg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QRdQnohU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QRdQnohU
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F2B8811EA
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:14:58 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-6756a6320f6so3492586d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 04:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790939697; cv=none;
 d=google.com; s=arc-20260327;
 b=JEnfyXOnYxYbkDfVJqalaK36cj0x+sAAc3th32+NOOfcxodvYU7cCS8Rmmobjc13YR
 FnGUS8YbYPxhzZh+Eq1RiSRihN5yGvhxItpjE4vP50/0vVFwj2TE14AstErDLDqBfeAK
 DKu1n5r9MdW00+7PI4aKxcGFPfZqGSt3ALUQ2B/EeQR3I2U0GKwgTLOvOOWNWjBcKkug
 x0kfV7YOL0FogpxDu5UBePWMMxWPNbQN+KtyHYIMoZajUjpsyTEF8lnbb/J7zqPu+m0u
 pKpSH3fLRulWqL7ElRHd58pVE3vqZ3aYSU+mtkbp/pueYs5Ll3iV4Xty9I1+f3zu+Ic3
 BBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mebiGyAk41ES4sVvYNmR3ybkITFxnN8sgTl4zi/+78s=;
 fh=RnfP8Alk6k2ShKUVtsvRLlLqsHkt7iY+yOjIpToT4eE=;
 b=IrrnQ3AZxQjLAwsKaslDa0PgW100Vj3cG1vHKT3aft53Iuqk7JU/oE0ZUZa11sg+V1
 4sxBU4bQmmN9AA6FOIQIAu2ZgfD1o8wrGKj99zQ8Z1o3UqYxbKu6WosxTTami8jodOWf
 wDBpJyR4XSMQZCF+kZABSLdAhzpWg+UFrO9ydt7M8EfGpcgDqpJxjUD0KzxLhI8O9VO5
 PJTYsZKDnu9LF/7AEcuDg+X56mzBR+feT1oZ6gVWInIlbIRG7oOKZRcMDDQPkUD1ZVut
 RYwC0HrXBdXXAQP8Zg4Q9yGYJ4uq3WPQpvM1jeXokfc0gQ6YXCEwx2BFxj7Lp2F9KTI6
 T0JA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790939697; x=1791544497;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mebiGyAk41ES4sVvYNmR3ybkITFxnN8sgTl4zi/+78s=;
 b=QRdQnohUrQkfOzQGBabo5vrFUYa4drl5esvXN06XH/z2apLSAKZ1UVH2XoKS8XCWXI
 gpB6C8TuvLPJpZMQ/MAVKR2tTcK47NzSWm5t5j+SRh02UouAFJ7yeR40j/ePWhTg0Y9x
 VMsLmHhAslJbi/pQQadeyJvxgGy7xwspeKx5y4+BmJ9RqmMSPHWKLNkOsE/fFkzTMY2e
 4ZdZ1UfimfEV5smz9oDL9T7kfPm2/Pi46v/6slD8I87V2MGg4mTK1fwTZmBfjEy50fvz
 0qmdp+WN9MNfDIIACy/SzNKfhIOfyda5XW34Os5j/zSaHbcobttDGucL82T2wVNPxEdv
 uF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790939697; x=1791544497;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mebiGyAk41ES4sVvYNmR3ybkITFxnN8sgTl4zi/+78s=;
 b=NDIsYrlOsfG0QzsQSzZsTQ8QvYppg6voHWdLcw8N/15hT5R722np+xPxoHek/oCRg9
 0sAW+wCI5oFsoAS32G6Y0DwD+A0EuPlYm6jaZDcStihZ8xy8X/DII+aW5zKxI+TVKCf5
 HhDL/N9CO30Qsb7FUxHWoSYhT/KD50LvoebWDSmTkpW8v3OwQ68NnctZWhniGL+F/hj+
 ui3wcDjXpmgdKvWiNqA1t2OfDQUAcEJD8SSZIZrXI9C8nCf0h3KzzwtuZszC+oVEotVW
 E8wE+Jvn9sqtNATL9nYsGSRNwae/cBokA3SLRaotS/d0DtWzLeTieN7/WeaVIcPSooii
 o0jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4NMU65+Ur1eDen2mtfNj5vyQl6Hu9BqZyiOCCHKDTzOmo1DRn6BcS7tUBuxcSl8A1rUfX4j8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIM48pfnQBxnutKeKTbE3oKSYHwieCFkD1/DplqFI41uU/aY823
 QK+a7ZoVSv/UVN930ByggfRmWj3lal4FEr6VWhxEiJc0kdegbGamw0I7fnbG82pTnA1A+3ji179
 CJBZ1mOkHzSQXXgdmiA2tF/V6jpHK6hbS9rFV3jX7jg==
X-Gm-Gg: AYBFou1+aZ+HKpBrM9taMoVmyUU7Op3nLWxG3nnXhsVlwtfCB5xMLj4VJZsXCs51pZK
 GHYu+w6WLuv4q/ffYuXTHzg1TK/RdLP0O+3OvWn+qSsUZYsLe6yAMNl2DhuvG7kHI31NUvNCPmY
 Ncu4E811Um2yqaAhJiuSXBACYMTieEc2v93HijjV1B49Z3CJd5pRUEkCr1Mrg2lCrF0ym+NN0T2
 05Y5iojKkKP4khLSfd7K2a2T3VCymwPrlVLUuN7yZvbyiRXqMMDZPghQ+UidoNlmVHNCky8wZ4u
 t8Aeh7Oa9YvN70+VIfdIVXawi2jMEiH99zS5AtE2aE8dEeGnqHGAIyhOfVjtKSwveUzQ9ld5A7V
 opWoWqhSskpfEe3RFVG6uUkl90BukWHc/WcNWJgwWxObBdVZHTcix0aBGCtfWYLjf9X5qpiBd3D
 5ZqozNgKrH+N50jlSk8akv23Mi7jFP6wUEt8NHMhEwfcj4vzzzTvO7sjMdijMbzkA9JgMfAHNiD
 92qhQ5dqYzg4HovvTQJgkq66JK1RDF+82g1LCRMKvlRNqsX09pdQGQcLhbfhbczd03A0A3CEgxK
 PxRt6Su/yelxoKTXc7EQ6vORK9y7EqjW29JRKdrRh2WxBRGhHdhy2zAF4ydvPQlTTPcH6psZsMa
 /HACaXk4Gvgx2s1vNhPOKGzy2QJDFroS8eftZYOIdyVKoG6bzGdVX72k=
X-Received: by 2002:a05:690e:1287:b0:672:9c30:bd0e with SMTP id
 956f58d0204a3-677ac10fc00mr931576d50.84.1790939696918; Fri, 02 Oct 2026
 04:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-7-jorge.ramirez@oss.qualcomm.com>
In-Reply-To: <20260918200641.2286077-7-jorge.ramirez@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Oct 2026 14:14:19 +0300
X-Gm-Features: AclHuK_d8CbENgm1_fk_lEYb560Hk8hUUSWoCE4kI-JjLp23er_rCJulOC0cXMw
Message-ID: <CAC_iWj+KoT=U65g6zAGt-bemG6o98yLnyuoMbLa341h0HARtJw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] optee: implement the RPMB subsystem interface for
 UFS
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com, 
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com, 
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com, 
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org, 
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Jorge,


> diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
> index 963cfd47824..b720d5d7b3f 100644
> --- a/drivers/tee/optee/optee_msg_supplicant.h
> +++ b/drivers/tee/optee/optee_msg_supplicant.h
> @@ -152,6 +152,14 @@
>   */
>  #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
>
> +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET     22
> +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT      23
> +#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES          24
> +
> +#define OPTEE_RPC_SHM_TYPE_APPL                0

drivers/tee/optee/optee_msg.h already contains these afaict.

> +
> +#define OPTEE_RPC_RPMB_UFS             1
> +
>  /*

other than that

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
