Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2488BC83F13
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 10:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A1386B20;
	Sat, 26 Aug 2023 12:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="B8zE3aI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174B986ACF; Sat, 26 Aug 2023 12:00:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED49786B20
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 12:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693044020; x=1693648820; i=xypron.glpk@gmx.de;
 bh=W1+fVk/O5xZdeejH9+KG/qC0JavCSanStVwPejgLsLQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=B8zE3aI7c8eVx7oaSYx1aFHNF15W57A6ek+KBJisb8nJGwlx1Yz4coY/5y1LjvHcZY+QprE
 gmYf3tqUo7Ek2yv0WcQg+bBoIyVz8yiT5w1v2QbDmkvzMkm7eb45rhnMaIIvEpRywOp3lgWSQ
 NiRaZbVkZ7srP9Xg8cpXpSiW9Pf+H6uUZo8Oo/sYLXdg3OcCDhCM4zF8lVdo8BMKAjT7cVxUP
 i+21czxQWPl6LRgbojelMFxaivlQYOqkI/v/xvxoIKrElCOYycg7mbDiZWVe7KgI9GTD2D7Fa
 nYbnMgiXCQ2gcYTGEY1Hpb79BfhUGVLqY8BiNdbnqxk0Br8mCPMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79u8-1pdNN93jci-017TXc; Sat, 26
 Aug 2023 12:00:19 +0200
Message-ID: <2000e1e6-539a-2aa6-a6c6-1fcc9db5d13d@gmx.de>
Date: Sat, 26 Aug 2023 12:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230826090633.239342-6-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SKmi5z2npo+sgI8JOxpo5F2yjNLVkw8ktSI3FjU8OAfmNsKvYO4
 SXVUK6kI0E6zEpjhXzDAqlG6PDJmf0TrxJP8dX4M9YUZemVBArUMiXa7DIGW8LIjVUyxt77
 5gb1P1MsLO5xqa3T+GV+KVX+MMLK5Skf/FhAkAstovBNcuQZSHOkv8f0dYAwnuZj0o4OgsE
 +WoFX8O+8dVjfuTUCatTA==
UI-OutboundReport: notjunk:1;M01:P0:tOLAaNGpcq8=;Cp4d7+R2vcdF7L+qRl1iaRXAQXf
 BHGkH1n5XEMLaKxHy/Ed2D3rmAXve4XDjLIneYwx/152+enBuAkyb7ygATQ0OzHU8iaH3gc07
 uLcVrxBy//hUc3sjVWd+A1KU/z2iyiVVIfSHuBOagP/5kfBwd8ROWoEmxWQ7xRDLhC4oEp2l8
 /dvuOW8vf50juNJsTCg2SlieuwHBplio7ggoYT7X+hD/JtZxCc9SEZY2ShqnYlouDh6z2VCK/
 H9ZsCl4D7L0zxwDG+rx2sctkip457Vbq7gL6K497KkiXHgqMQ0zz3RUzm3fvIu72uN4HqjoX1
 NB8+0c7BvDpZRMv2xn4lw2GQeatUO6nXG0a3AgTFu3Sj56mAOH2rgXhJOdw3T2Dkht28hEfTb
 GOYjLyFbQr3C40Q/IlIKjSA1o6Rbt5czZaEMeH8FTdpcN5U9z2JMk0gYW9GoMoV7PvKoSax+D
 pg02QZGxGHyFPnhRyvVQ5iGA5BHsbsU2CsFITNeq1/+YOVG6Sa2fVhBR98XS8MlzfbsCyD7cl
 5QkYWq/XjtKI27XS5+pGAxpjcTObXaDSQLCLG42W2iJwTN4QV++iq1HrQZfwzWD3yLW6xDaPv
 qcjckEI3voGX1bXvnKRXRS9XzrAXbQIw+sQpwa8pqjld2+vW6WPVT48bXi6D6UjEqTgmEZY/O
 6DFfN/B9YVm9dT+d4A72iaLpFiLSOCrzaV9nXc8lgocKCFz6DvxdGydeMgrvrhktk4NxyJ+YJ
 3Om4D6fwEcAFwkcjazXDf0c6t/iXASeeU3hISs0M91Px9fv1fDxmiyMd/pW3d5z6nVO2Plw+Y
 Aoz6EiEeygBeCbh4FLuROVp2c7G+4nTwe2ugTc0ANMYX193/t5W590WXqXjlXYWuagmdjQ0+x
 kuV7iOFFdypQYYNMP1pYs9wKnYlxkq8kUiW61Uh3pgnVLsew4CVS5/bS8c8W+mnaijDnLJwyv
 723lMu+FxXZHVeDNNRjU8JYOj4o=
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/26/23 11:06, Sughosh Ganu wrote:
> Add a document explaining the need for removal of non-compliant
> devicetree nodes and properties. Also describe in brief, the macros
> that can be used for this removal.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Thanks for properly documenting the change.

Warning, treated as error:
doc/develop/devicetree/dt_non_compliant_purge.rst:
document isn't included in any toctree

Please, add the document to doc/develop/devicetree/index.rst

Please, run make htmldocs before resubmitting.

> ---
>   .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++++++++
>   1 file changed, 64 insertions(+)
>   create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
>
> diff --git a/doc/develop/devicetree/dt_non_compliant_purge.rst b/doc/dev=
elop/devicetree/dt_non_compliant_purge.rst
> new file mode 100644
> index 0000000000..c3a8feab5b
> --- /dev/null
> +++ b/doc/develop/devicetree/dt_non_compliant_purge.rst
> @@ -0,0 +1,64 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Removal of non-compliant nodes and properties
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The devicetree used in U-Boot might contain nodes and properties which
> +are specific only to U-Boot, and are not necessarily being used to
> +describe hardware but to pass information to U-Boot. An example of
> +such a property would be the public key being passed to U-Boot for
> +verification.
> +
> +This devicetree can then be passed to the OS. Since certain nodes and
> +properties are not really describing hardware, and more importantly,
> +these are only relevant to U-Boot, bindings for these cannot be
> +upstreamed into the devicetree repository. There have been instances
> +of attempts being made to upstream such bindings, and these deemed not

but these were not deemed fit

> +fit for upstreaming. Not having a binding for these nodes and
> +properties means that the devicetree fails the schema compliance tests
> +[1]. This also means that the platform cannot get certifications like
> +SystemReady [2] which, among other things require a devicetree which

%s/require/requires/

> +passes the schema compliance tests.
> +
> +For such nodes and properties, it has been suggested by the devicetree
> +maintainers that the right thing to do is to remove them from the

%s/that the right thing to do is//

> +devicetree before it gets passed on to the OS [3].

%s/on to/to/

> +
> +Removing nodes/properties
> +-------------------------
> +
> +In U-Boot, this is been done through adding information on such nodes

%s/is been done through/is done by/

> +and properties in a list. The entire node can be deleted, or a
> +specific property under a node can be deleted. The list of such nodes
> +and properties is generated at compile time, and the function to purge
> +these can be invoked through a EVT_FT_FIXUP event notify call.
> +
> +For deleting a node, this can be done by declaring a macro::
> +
> +	DT_NON_COMPLIANT_PURGE(fwu_mdata) =3D {
> +		.node_path      =3D "/fwu-mdata",
> +	};

Where should such a macro be placed?

> +
> +Similarly, for deleting a property under a node, that can be done by
> +specifying the property name::
> +
> +	DT_NON_COMPLIANT_PURGE(capsule_key) =3D {
> +		.node_path      =3D "/signature",
> +		.prop           =3D "capsule-key",
> +	};

Why is capsule_key needed twice here? What would be the effect of:

DT_NON_COMPLIANT_PURGE(voodoo) =3D {
	.node_path      =3D "/signature",
	.prop           =3D "capsule-key",
};

> +
> +In the first example, the entire node with path /fwu-mdata will be
> +removed. In the second example, the property capsule-key
> +under /signature node will be removed.
> +
> +Similarly, a list of nodes and properties can be specified using the
> +following macro::
> +
> +	DT_NON_COMPLIANT_PURGE_LIST(foo) =3D {

What does foo refer to here? Can this parameter be eliminated from the
syntax?

Will the application of the removals be sorted alphabetically by this
argument?

What will happen if a property or node does not exist at time of
removal? Hopefully that does not stop the boot process but is silently
ignored.

> +		{ .node_path =3D "/some_node", .prop =3D "some_bar" },
> +		{ .node_path =3D "/some_node" },
> +	};

Why do you need the first element in your example?
Wouldn't deleting /some/node imply that all its children are deleted?

Why do we need separate properties .node_path and .prop. It would be
less effort to write:

DT_NON_COMPLIANT_PURGE_LIST() =3D
{
	"/some_node_1/some_property_1",
	"/some_node_1/some_property_2",
	"/some_node_2",
}

I assume the macro does its job irrespective of non-compliance.
Why not call it DT_PURGE()?

Best regards

Heinrich

> +
> +[1] - https://github.com/devicetree-org/dt-schema
> +[2] - https://www.arm.com/architecture/system-architectures/systemready=
-certification-program
> +[3] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7z=
f26L_GV2oS6cg-5qg@mail.gmail.com/
