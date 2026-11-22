Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E60606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sra3eTfq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhU4W4H/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D2E7405AB;
	Sun, 22 Nov 2026 23:34:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJcggUH_H72Z; Sun, 22 Nov 2026 23:34:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0382740514
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795390481;
	b=ctxe3XdEue52nuuEeMVOu2uUpqKf881A2JH4jT2y5o5JCjNhIWM72Ms6ie2hL40SsYyZ
	 5IP0zpaaqw28aiv943Iw+97vFdMjvESt364NeyQ0fDO8fVluuWw3sbaFB0dL8s5PGk35l
	 tF8Y1JEZRYTdjEnNqzw0wt9YzHWIbbP7zTpHp2RUZTphRQr5x9l62nRExxbYmGquUDRUq
	 3BiMSIITjFD3wE3IldabWLOg3BY5kszSm85oem+1VXy4F9NXw6DWGj7yMTAPlJNVBZclw
	 UCucGS+j7lXbELztkwSlLCzd+EzgOjkpao65W/NNPN5KWfjjO/qs2X6SdjYg0cqPvng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795390481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rMj3jHGh6zNGK9Elqx+ccnmrM9sRoSO6VBhXTAil5i4=;
	b=FGfzwChZLJeQUAporqBe6tWl0fSHjqxUdbFCt0XFz/pSKjh9++uS0dNCzQMEMi1z9zcJ
	 PbrtWbu+cavXl0IegS22Gg50tMQlGzTUDt3xSdSFzVNqfvbCkFiF31EihXEm/WLbbpUvX
	 GJVhqasS+fs6SOkQcHGpxtEz6wVjPOG+GV7TmCyBQyxra2+ERoqwPnNuTUx8UvMREL8VF
	 cpkR3ZEXg/oFSdWDS3WrsVeObIQBajvngEAQhg8kUBzv5dLTXLEdkEC48tYgwYyb7RjSF
	 HRRdbI43qos4S7Dn5A9pxRXTlqFbsJEyMF7QvIUJI1dvgSDpZPgTYzCighYZWST10lQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795390481;
	bh=rMj3jHGh6zNGK9Elqx+ccnmrM9sRoSO6VBhXTAil5i4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sra3eTfqglhj6ILjS4+1DAMEieZ3+5kmXbzYm3ahVSpGu2VFAwUmRi8XhacRWDRzo
	 Q2P58ROKTTRUVCjdVnhgZXcPyzcmv1QjlNDYXm3F3Irykdx7CfsZux7vbEu2VS1sEB
	 sl2EKtyGamqW5KKH0UMR7cLOmiUFmi8b3yr3oWhVitlEMV7qiV5ryjLXmAA4RZAEZl
	 lh7shjGFOhJQkr3xosaSgyji//BuDxPXNBGwailWYYreGYd3grO8FunDkKAS+/kUKB
	 wwa6cFrFaAki7ES98p/vGQpHdYEUhYpBJC4nqP5MwhJbHL/RUStFVlm0hngrl0UJN9
	 B8nlvP/d/jR2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0382740514;
	Sun, 22 Nov 2026 23:34:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28149260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1980B80AC4
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ALcT-Claa7pe for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 23:34:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F79780A92
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RhU4W4H/
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F79780A92
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:34:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AFDD4484B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0001F008B2
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795390477;
 bh=rMj3jHGh6zNGK9Elqx+ccnmrM9sRoSO6VBhXTAil5i4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=RhU4W4H/XYj4CNeqNDc9GtFZc0+cxWH8tR52Ecv//79PxSs/jU17mFV24fzGgyLjo
 Ffc/fvYU7ehzTppXF6dvA3zX820ubDoSYjYcUKZ8ekOqys83wtmsrtlJ8RMgBlSF7X
 SI7vaIQDl7y8xaPGkqtVcEXN9At2CYJqeOUM400SBvItIH3CqqPGzDJMDdi/oaHJuJ
 s/VCLHkz82DD06UF/cWvA1c+/hkewOBhNt+sVuyj+jjNEk4ZiKfEw84QM+EOlLLJ+m
 +Rlc7uIjRB1D+eQmXlBNr2WxCXMAxYmix+utOoogv4SoAeubgw9Soe8NUOE9cv+De+
 tATM5QJZ7ezaw==
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5bccecba199so2544192e87.1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 15:34:37 -0800 (PST)
X-Gm-Message-State: APuU4Z8a/rkPn4QAsqqiPZr55phmxXOmwY66xO96lzEFT4vddakG3UnJ
 mIdTmXjL6ZDrTFU8/5X7RgaeAYLh212Y/Chdgv9yl00zJI22BG7/AeDNKcz/o4hHaxhCYswxQd2
 HxTBtkpz7H98Xto0DW3iJsQ90mTlV92k=
X-Received: by 2002:a05:6512:3192:b0:5bf:a221:ef55 with SMTP id
 2adb3069b0e04-5c1bc815a36mr3103626e87.50.1795390476302; Sun, 22 Nov 2026
 15:34:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
 <20261116174138.3488177-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261116174138.3488177-3-marek.vasut+renesas@mailbox.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 23 Nov 2026 00:34:24 +0100
X-Gmail-Original-Message-ID: <CAD++jLnBVmMocwD9BUOBR8ZEu2T+CJNx42a1hhjhX6KsH-Nbeg@mail.gmail.com>
X-Gm-Features: Aa3M54pmrpBRvzdXHBZSFrgprOemNSN2gpdn2bt0TbKBJ8BiUr3bNxOCgXTEO9E
Message-ID: <CAD++jLnBVmMocwD9BUOBR8ZEu2T+CJNx42a1hhjhX6KsH-Nbeg@mail.gmail.com>
Subject: Re: [PATCH 3/3] power: pmic: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, 
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Julien Stephan <jstephan@baylibre.com>,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <u-boot@0leil.net>, Ryder Lee <ryder.lee@mediatek.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 6:41=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
