Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F00606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NjhSLa7u;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=H6vX1xqi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C324540ABA;
	Fri, 30 Oct 2026 06:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W69zYGnIOJzZ; Fri, 30 Oct 2026 06:29:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1515840AAF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793341771;
	b=k9lt7D2a8ZuHP8+ktFK2wDb8gE5qhGC8/ZQG9kY4SJoMIX3iiLYwFVHQbtzDcsvjsDbm
	 a81/c0ZT47BxFw6hOBODu7sKtnNIG9MI6auBzIBHiDwLJW8iqYCn0SCr6Zm3939sDL/vD
	 fOkh7mEuEb4LKY/gUMKv8RH8xdWX+2aEolJ2KCgH2125Rs+7QeEpR/Lw7ZdpW9jnuVlQz
	 GkonSOkDFVPE3kSWuyZ7DaPFWpOXxXwBTJVNXxtKguCk3m5M3ve0k9OJDtj5AuMnjef5/
	 iVv8cr6pyPbDnYUlQtAgW+AI7nM7fiQQzZb7XrLYKz5wox7w2kwRqyr8hzdpCzQTfJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793341771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gHaUSYkvbH5gYMamRgHZkMeahNY+VPWGcfnGH5clHmY=;
	b=bz3Dws+8X9KPysCQDHe73y67J1gQ09uYYIjHsbHBntqcgKcBrUmYAx+cvUgKauyJrLly
	 flX5oXsD7sGPLV823D/89lkVMfDSyFVwC9ftnnL3L8+3I0wsqj0b1Ft8SyKGKJ3zCSe2j
	 iFpNeLlAnvU+B/KYfTvd3ifaAtL0hlx3eCfPrzgUAwTlbklHs80azIcOu9aJjBQiIpXK+
	 Yh6CUIjGDPch5NIu5GhT8CjnT37plQpo43zs0qDPeqtepDC+LIXeT+WRI6C4IcYeq0u8o
	 B58ipgNaIcL6yPT8RRG1woHF+17TZ/MZ/8sX0j+tbjUoW3Oh/aeejBPXY3Fe4c/TOIw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793341771;
	bh=gHaUSYkvbH5gYMamRgHZkMeahNY+VPWGcfnGH5clHmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NjhSLa7u8DdENKb6lrsGnVgYbg6+cN9wqDSV5rgMVk6Z+fjXEq46Jz5jmaQzQMsp2
	 GMSQy6oTExD3IE/uW8KmCVYWS79KIiHCmudUWyyAfgTl4mUCxXrELizTrRmRgrWxLK
	 KndGQ9sHDfrWv5BAFjoAh4KAZambFp3Zv3UDckGq1oMdS6KO3Tzj0lDKVc8BwL9RSd
	 MqD92gSaLdwKV/BHPPstnNv2HPqlxvwFi2WGBKVRGlNj5hOoTIM/5tcWFWr8kk8EqQ
	 w70H7V+XWcIjlo9Th7FDI23ZqLXmfNhhWb9jeRGdFuknSOxp7jD5HdKch+/s/fW/Ss
	 WGZmLFpj0wf3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1515840AAF;
	Fri, 30 Oct 2026 06:29:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B50F712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70AD380DDB
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xS_jCMWL99fE for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C19980DD6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.3
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793341768;
 b=G+UcoWprAd/vggCfSuhiiifEGN91xyeFRm6Fc35MntwDl/mszvgYkBvXuhFUmsqhWifQ
 6JJA5OM8LIkzA/HpjMjOzQvmtrKZUmQPlaAS6OWrQZhlud1/KypWx0K5k3LRzAY18HKtR
 Jyz9pNHPWMAoe+PcUCU1Pl1hcsUsge0KC5I9BZ62S2e1yDAmVLkC1XLTVA0XWv3SrTZuJ
 JoamVbfzz84QLcWqyoNGv2YrotKI7iftoQNIJQyczotDi+50YmMxzfg4iXryFa07N6wZG
 LhN4NrdOtyhxAUAeQdh2v/rlG1gRkefnK081ucLL81c0cYRzs1NAIym0Xvc4zPxt0dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793341768;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=gHaUSYkvbH5gYMamRgHZkMeahNY+VPWGcfnGH5clHmY=;
 b=foqvLlqymSnrnQZeHmT722a7O2DEU9mhAeyxabUuX9IvGpYQXvyUYZqY5EtF/lRea+v3
 itmJF6+hauSZCuMyo7qOyL2VOjapuF5UFQNNWqIiNPYpWMc4Z0HjZ/GjUBJaB/TR6LHGu
 WHQwZU36IyDLrFW9XAsrvk3NnK8+jnt7szMULROnK6mIFtN13ugGyYfS90QElY65OOZcR
 8YSQAAJE6L9MEruwp8w2exxfOxhtGKEJRHKjF6Lc8JEFjCQHRnKGKsq95RmuswCU5quDQ
 kt2AB9Dg9mkEGPpxrYQR5hDoKN4PljGMYuSWnXYdb2dlJ0MiMx3pZHLxydriRX1H7Zg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=H6vX1xqi; 
 arc=none smtp.remote-ip=212.27.42.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.3;
 helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=H6vX1xqi
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C19980DD6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:29:27 +0000 (UTC)
Received: from L30177.local (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 3164713F846;
 Fri, 30 Oct 2026 07:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793341765;
 bh=7T7IohAr8urVQqU0zw3COd7JLXWtThAGY0vYqfT3Q0s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H6vX1xqiNPG/AkT+b+42DwuRtGaClaP4TlBjIyQHz7rUzyWPDCC+U4v61UDdpOjPY
 cBlYL8XomsZVltH0W5aZM6ysfQk8R8Tg+Fnc/may0c7GgNkfKxoa+Hgv6E7i+uwMym
 om5RUXiymM8KRN7EVShpRiafcMCGzFfybK0mavjMW9lVdUuriMAsg2zeV0bNF4801W
 yIyFCwCxXhMwSorp9csPm7dZK225qfolBc9ZE/BfnFJT6ZpOS7jBIqvMXmiWFkNajC
 rINgcsV/m7TimUbRk4NC3P7wZELIEmhF9prgXKnHNo6f3Wuo+eEe8Rdscw+N1pgiA5
 VeAxbH7af/Niw==
Date: Fri, 30 Oct 2026 07:29:19 +0100
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@oss.nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1] pci: layerscape: bind LX2160A rev2 aligned with Linux
 kernel
Message-ID: <auQ5P0e4Fn-64cyl@L30177.local>
References: <20261028145705.2407296-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028145705.2407296-1-vjardin@free.fr>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peng, Tom,

I am not used with uboot release cycle/policy, for such small
case:

> +++ b/drivers/pci/pcie_layerscape_rc.c
> +	{ .compatible = "fsl,lx2160ar2-pcie", .data = (ulong)&ls1028a_drvdata },

since I posted this after the -rc1, should it wait for next (v2027.04), or
could it be considered for v2027.01 ?

It only lets uboot bind the LX2160A rev2 PCIe nodes of the upstream
DTS, and no in-tree board is affected, so I hope it could be acceptable.

Thank you for sharing your view on it,
  Vincent
